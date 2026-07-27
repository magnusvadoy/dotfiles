# Agent instructions

These are common instructions for all agents, in all scenarios.

## General guidelines

- Never use the em dash "—". Use plain dash "-" instead.
- Never manually modify CHANGELOG.md files, or any other files that are marked as auto-generated.
- When making technical decisions, do not give much weight to development cost. Instead, prefer quality, simplicity, robustness, scalability and long term maintainability.

## Git

- When creating feature branches, use the following naming convention: `mavad/<short-description>`. For example, if you're working on a feature related to user authentication, you might name your branch `mavad/user-authentication`. This is a personal preference, and should not be enforced on others.
- When writing commit messages, use clear and descriptive commit messages that explain the purpose of the changes. A good commit message should include a brief summary of the changes made and the reason for those changes.
- When creating pull requests on GitHub, set them initially to draft.
- NEVER auto-add your agent name as co-author in the commit message.
- NEVER automatically create tags. Don't push without asking.

## Projects

- When creating new project, always use the native tooling for that language. For example, use `npm` for TypeScript/JavaScript projects, and `go mod` for Go projects. This ensures that the project is set up correctly and follows best practices for that language.
- Always use a linter for the language you're working with. Ask if unclear which linter to use for other languages.
- Always use a formatter for the language you're working with. Ask if unclear which formatter to use for other languages.

## Secrets Hygiene

- Never hardcode credentials, API keys, or tokens in source code
- Never commit `.env` files — add to `.gitignore` immediately
- Use environment variables or a secrets manager (Vault, AWS Secrets Manager, etc.)
- If a secret is accidentally committed: rotate it immediately, then clean git history
- Error messages must not leak internal secrets, stack traces, or system paths to users
- Log fields must not include tokens, passwords, or raw credentials — mask or omit
