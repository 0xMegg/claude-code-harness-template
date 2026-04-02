# Git Rules

## Commits:
- Commit messages: `type: short description` (feat, fix, refactor, test, docs, chore)
- One logical change per commit
- Never commit secrets, .env files, or node_modules
- Run tests before committing

## Branches:
- Feature branches from main: `feat/short-description`
- Bug fix branches: `fix/short-description`
- Never push directly to main/master
- Keep branches short-lived (merge within days, not weeks)

## Pull Requests:
- PR title matches commit convention
- Include what changed and why in the description
- Self-review the diff before requesting review
- Address all review comments before merging
