# Git

When creating feature branches, use the following naming convention: `mavad/<short-description>`. For example, if you're working on a feature related to user authentication, you might name your branch `mavad/user-authentication`.

When committing changes, use clear and descriptive commit messages that explain the purpose of the changes. A good commit message should include a brief summary of the changes made and the reason for those changes. For example: "Add user authentication feature to improve security."

Never automatically create tags. Don't push without asking.

When creating pull requests on GitHub, set them initially to draft.

# Go

When creating log fields, always prefix them with "ai.".

When formatting Go code in TV 2 projects use goimports-reviser:

```bash
goimports-reviser -company-prefixes=bitbucket.org/tv2norge,golang.tv2.no -project-name=bitbucket.org/tv2norge -imports-order=std,project,company,general -format $FILENAME
```

In other projects, default to gofmt.
