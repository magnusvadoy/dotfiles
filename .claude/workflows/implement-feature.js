export const meta = {
  name: "implement-feature",
  description:
    "Plan (Opus high) -> implement (Opus medium) -> 3 review/respond rounds -> final report",
  whenToUse:
    "Implementing a new feature end to end with built-in review rounds. Pass the feature request as args.",
  phases: [
    { title: "Plan", detail: "Opus, high effort, read-only", model: "opus" },
    { title: "Implement", detail: "Opus, medium effort", model: "opus" },
    {
      title: "Review loop",
      detail: "3 rounds: reviewer -> responder decides (Opus, high effort)",
      model: "opus",
    },
    { title: "Report", detail: "Sonnet, medium effort", model: "sonnet" },
  ],
};

const ROUNDS = 3;
const feature = typeof args === "string" ? args : args?.feature;
if (!feature)
  throw new Error(
    'Pass the feature request as args, e.g. args: "Add CSV export to the reports page"',
  );

// ---------- Schemas ----------
const PLAN = {
  type: "object",
  properties: {
    summary: { type: "string" },
    steps: {
      type: "array",
      items: {
        type: "object",
        properties: {
          title: { type: "string" },
          details: { type: "string" },
          files: { type: "array", items: { type: "string" } },
        },
        required: ["title", "details", "files"],
      },
    },
    testStrategy: { type: "string" },
    risks: { type: "array", items: { type: "string" } },
  },
  required: ["summary", "steps", "testStrategy", "risks"],
};

const IMPL = {
  type: "object",
  properties: {
    summary: { type: "string" },
    filesChanged: { type: "array", items: { type: "string" } },
    deviationsFromPlan: { type: "array", items: { type: "string" } },
    testsRun: { type: "string" },
  },
  required: ["summary", "filesChanged", "deviationsFromPlan", "testsRun"],
};

const REVIEW = {
  type: "object",
  properties: {
    findings: {
      type: "array",
      items: {
        type: "object",
        properties: {
          id: { type: "string" },
          severity: {
            type: "string",
            enum: ["critical", "major", "minor", "nit"],
          },
          file: { type: "string" },
          issue: { type: "string" },
          suggestion: { type: "string" },
        },
        required: ["id", "severity", "file", "issue", "suggestion"],
      },
    },
  },
  required: ["findings"],
};

const DECISIONS = {
  type: "object",
  properties: {
    decisions: {
      type: "array",
      items: {
        type: "object",
        properties: {
          findingId: { type: "string" },
          decision: {
            type: "string",
            enum: ["accepted", "rejected", "partially_accepted"],
          },
          rationale: { type: "string" },
          changeMade: { type: "string" },
        },
        required: ["findingId", "decision", "rationale", "changeMade"],
      },
    },
  },
  required: ["decisions"],
};

const GIT_RULES =
  "Do NOT commit, stash, reset or switch branches. All work stays as uncommitted changes in the working tree. " +
  "To see the current changes, use `git status` and `git diff HEAD` (include untracked files).";

// ---------- 1. Plan (Opus, high effort) ----------
phase("Plan");
const plan = await agent(
  `You are a senior engineer planning a feature. Explore the repository and write a concrete implementation plan.
Do NOT modify any files - this is read-only planning.

Feature request:
${feature}

Follow the repo's existing conventions. Name the exact files to create or change, the order of work, how to test it, and the risks.`,
  {
    label: "planner",
    phase: "Plan",
    model: "opus",
    effort: "high",
    schema: PLAN,
  },
);
log(`Plan ready: ${plan.steps.length} steps`);

// ---------- 2. Implement (Opus, medium effort) ----------
phase("Implement");
const impl = await agent(
  `Implement this feature by following the plan below. Run the relevant tests/linters and fix failures.
${GIT_RULES}

Feature request:
${feature}

Plan (JSON):
${JSON.stringify(plan, null, 2)}`,
  {
    label: "implementer",
    phase: "Implement",
    model: "opus",
    effort: "medium",
    schema: IMPL,
  },
);
log(`Implemented: ${impl.filesChanged.length} files changed`);

// ---------- 3. Review loop ----------
phase("Review loop");
const rounds = [];
for (let r = 1; r <= ROUNDS; r++) {
  const history = rounds.length
    ? `Earlier rounds (do not re-raise rejected findings unless you have NEW evidence):\n${JSON.stringify(rounds, null, 2)}`
    : "This is the first review round.";

  const review = await agent(
    `You are a critical code reviewer (round ${r}/${ROUNDS}). Review the uncommitted changes for this feature.
Look for bugs, missed requirements, edge cases, security issues, missing tests, and violations of repo conventions.
Do NOT modify any files. Prefix finding ids with "R${r}-" (e.g. R${r}-1). Return an empty list if nothing is worth raising.
${GIT_RULES}

Feature request:
${feature}

Plan:
${JSON.stringify(plan, null, 2)}

${history}`,
    {
      label: `reviewer r${r}`,
      phase: "Review loop",
      model: "opus",
      effort: "high",
      schema: REVIEW,
    },
  );
  log(`Round ${r}: ${review.findings.length} findings`);

  let decisions = { decisions: [] };
  if (review.findings.length) {
    decisions = await agent(
      `You own this implementation. A reviewer gave the feedback below. For EACH finding, decide whether to accept,
partially accept, or reject it, using your own engineering judgment - you are not obliged to agree.
Apply the changes you accept, re-run relevant tests, and explain every decision.
${GIT_RULES}

Feature request:
${feature}

Review findings (round ${r}):
${JSON.stringify(review.findings, null, 2)}`,
      {
        label: `responder r${r}`,
        phase: "Review loop",
        model: "opus",
        effort: "high",
        schema: DECISIONS,
      },
    );
  }
  rounds.push({
    round: r,
    findings: review.findings,
    decisions: decisions.decisions,
  });
}

// ---------- 4. Final report ----------
phase("Report");
const report = await agent(
  `Write a final Markdown report for this feature implementation. Inspect the final diff yourself.
${GIT_RULES}

Include these sections:
1. Summary - what the feature does and how it was built
2. Changes - files changed and what changed in each (from the actual final diff)
3. Review findings - a table per round: id, severity, issue, decision (accepted/rejected/partial), rationale
4. Not implemented - every rejected or partially accepted finding and why
5. Deviations from the plan, open risks, and suggested follow-ups

Feature request:
${feature}

Plan:
${JSON.stringify(plan, null, 2)}

Initial implementation:
${JSON.stringify(impl, null, 2)}

Review rounds:
${JSON.stringify(rounds, null, 2)}`,
  { label: "reporter", phase: "Report", model: "sonnet", effort: "medium" },
);

return { report, plan, implementation: impl, rounds };
