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
