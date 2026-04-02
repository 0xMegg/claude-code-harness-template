# Project Contract

## Project
- Name: {{PROJECT_NAME}}
- Type: {{PROJECT_TYPE}} (e.g., Web App, Mobile App, API Server, CLI Tool)
- Stack: {{TECH_STACK}}

## Build & Test Commands
- Install: `{{INSTALL_CMD}}`
- Dev/Run: `{{DEV_CMD}}`
- Build: `{{BUILD_CMD}}`
- Test all: `{{TEST_CMD}}`
- Test single: `{{TEST_SINGLE_CMD}}`
- Lint/Analyze: `{{LINT_CMD}}`
- Format: `{{FORMAT_CMD}}`

## Folder Boundaries
- Source code: `{{SRC_DIR}}`
- Tests: `{{TEST_DIR}}`
- Config: project root
- Do NOT modify: `.env`, `{{BUILD_OUTPUT}}/`, `{{LOCK_FILE}}`

## Architecture
- {{ARCHITECTURE_PATTERN}} (e.g., Feature-First, MVC, Clean Architecture)
- State management: {{STATE_MANAGEMENT}}
- Routing: {{ROUTING}}
- Data access: {{DATA_ACCESS_PATTERN}} (e.g., Repository pattern, direct ORM)

## Coding Conventions
- Language: {{LANGUAGE}}
- Naming: {{NAMING_CONVENTION}}
- File naming: {{FILE_NAMING}}
- Imports: {{IMPORT_STYLE}}
- Error handling: {{ERROR_HANDLING}}

## Work Protocol
1. Read the relevant code before modifying
2. Keep changes feature-local first
3. Run lint/analyze after every change
4. Run tests if they exist for the changed area
5. Make the smallest change that completes the task
6. Update `handoff/latest.md` with what changed and what's next

## Restrictions
- Never commit secrets, API keys, or .env files
- Never run `rm -rf` on project directories
- Never force push to main/master
- Never modify {{PROTECTED_FILES}} without asking
- Never add dependencies without stating the reason
- Never do repo-wide refactor without explicit request

## Key References
- `{{SCHEMA_FILE}}` — data schema (source of truth), if applicable
- `context/about-me.md` — project background and goals
- `context/working-rules.md` — work principles and protocols
- `context/decision-log.md` — past decisions and rationale (prevents re-litigating)
- `handoff/latest.md` — current state and task queue (read at every session start)

## 3-Role Workflow
- `templates/role-planner.md` — Planner: read-only, writes plans to `outputs/plans/`
- `templates/role-developer.md` — Developer: implements + verifies, does NOT commit
- `templates/role-reviewer.md` — Reviewer: reviews, commits + pushes on APPROVE

## Templates & Skills
- `templates/epic-plan.md` — epic decomposition into slices
- `templates/plan.md` — work plan format (per slice/task)
- `templates/handoff.md` — session handoff format
- `templates/bug-fix.md` — bug fix workflow format
- `skills/bug-fix/` — 7-step bug fix workflow
- `skills/code-review/` — code review checklist

## Rules (auto-applied)
- `.claude/rules/api.md` — API/DB rules
- `.claude/rules/frontend.md` — UI rules
- `.claude/rules/testing.md` — testing rules
- `.claude/rules/git.md` — commit and branch rules

## Outputs
- `outputs/plans/` — Planner artifacts
- `outputs/reviews/` — Reviewer artifacts
- `outputs/archive/` — resolved past documents
