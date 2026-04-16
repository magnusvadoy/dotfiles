# Git

When creating feature branches, use the following naming convention: `mavad/<short-description>`. For example, if you're working on a feature related to user authentication, you might name your branch `mavad/user-authentication`. This is a personal preference, and should not be enforced on others.

When committing changes, use clear and descriptive commit messages that explain the purpose of the changes. A good commit message should include a brief summary of the changes made and the reason for those changes. For example: "Add user authentication feature to improve security."

Never automatically create tags. Don't push without asking.

When creating pull requests on GitHub, set them initially to draft.

# Code

When creating new project, always use the native tooling for that language. For example, use `npm` for TypeScript/JavaScript projects, and `go mod` for Go projects. This ensures that the project is set up correctly and follows best practices for that language.

Always use a linter for the language you're working with. Linters help catch common mistakes and enforce coding standards, which can improve the overall quality of the codebase. For example, use ESLint for TypeScript/JavaScript projects. Ask if unclear which linter to use for other languages.

Always use a formatter for the language you're working with. Formatters help ensure that the code is consistently formatted, which can improve readability and maintainability. For example, use Prettier for TypeScript/JavaScript projects. Ask if unclear which formatter to use for other languages.

## Go

When creating log fields, always prefix them with "ai.".

When formatting Go code in TV 2 projects use goimports-reviser:

```bash
goimports-reviser -company-prefixes=bitbucket.org/tv2norge,golang.tv2.no -project-name=bitbucket.org/tv2norge -imports-order=std,project,company,general -format $FILENAME
```

In other projects, default to gofmt.

# Testing

Always write tests for new functions and non-trivial logic. Tests are not optional.

## Go

- Use table-driven tests for all functions with multiple input cases
- Use subtests (`t.Run`) to group related cases
- Use `t.Helper()` in helper functions
- Use `t.Cleanup()` for resource teardown — never defer in test body for shared resources
- Run with race detector in CI: `go test -race ./...`
- Target: 80%+ general code, 90%+ public APIs, 100% critical business logic

## TypeScript / JavaScript

- Use `describe`/`it` blocks — group by unit under test, name by behavior
- Test behavior, not implementation — don't assert internal state
- Mock at boundaries (HTTP, DB, time) — not inside business logic
- Use `beforeEach`/`afterEach` for setup/teardown, not shared mutable state

## General

- Write the test before or alongside the code, not after
- Test error paths, not just happy paths
- Name tests: `TestFuncName_Scenario_ExpectedResult` (Go) or `"does X when Y"` (TS)
- Delete flaky tests or fix them — never skip and ignore

# Secrets Hygiene

Never log secrets, tokens, passwords, or PII. Never commit them to source control.

- Never hardcode credentials, API keys, or tokens in source code
- Never commit `.env` files — add to `.gitignore` immediately
- Use environment variables or a secrets manager (Vault, AWS Secrets Manager, etc.)
- If a secret is accidentally committed: rotate it immediately, then clean git history
- Error messages must not leak internal secrets, stack traces, or system paths to users
- Log fields must not include tokens, passwords, or raw credentials — mask or omit
