# Project Contract

## Project
- Name: {{PROJECT_NAME}}
- Type: Web/App Development
- Stack: {{TECH_STACK}} (e.g., Next.js, React, Node.js, Python/FastAPI)

## Build & Test Commands
- Install: `{{INSTALL_CMD}}` (e.g., npm install)
- Dev server: `{{DEV_CMD}}` (e.g., npm run dev)
- Build: `{{BUILD_CMD}}` (e.g., npm run build)
- Test all: `{{TEST_CMD}}` (e.g., npm test)
- Test single: `{{TEST_SINGLE_CMD}}` (e.g., npm test -- --testPathPattern={{file}})
- Lint: `{{LINT_CMD}}` (e.g., npm run lint)
- Type check: `{{TYPE_CMD}}` (e.g., npx tsc --noEmit)

## Folder Boundaries
- Source code: `src/`
- Tests: `tests/` or `__tests__/`
- Config files: project root
- Do NOT modify: `.env`, `.env.local`, `node_modules/`, `dist/`, `build/`

## Coding Conventions
- Language: TypeScript (strict mode)
- Naming: camelCase for variables/functions, PascalCase for components/classes
- Imports: absolute paths preferred (e.g., `@/components/Button`)
- Error handling: use typed errors, no silent catches
- Comments: only where logic is non-obvious

## Work Protocol
1. Read the relevant code before modifying
2. Run tests after every change
3. If tests fail, fix before moving on
4. Write a 3-line summary of what changed and why in handoff.md after completing work

## Restrictions
- Never commit secrets, API keys, or .env files
- Never run `rm -rf` on project directories
- Never force push to main/master
- Never modify CI/CD pipeline files without asking
- Never install new dependencies without stating the reason

## Context Files
- `context/about-me.md` — project background and goals
- `context/working-rules.md` — work principles and protocols
- `templates/plan.md` — use this format for work plans
- `templates/handoff.md` — use this format for session handoffs
