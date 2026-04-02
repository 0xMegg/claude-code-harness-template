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
- `handoff/latest.md` — current state and task queue (매 세션 시작 시 필독)

## 3-Role Workflow
- `templates/role-planner.md` — Planner: 읽기 전용, 계획 작성 → `outputs/plans/`
- `templates/role-developer.md` — Developer: 구현+검증, 커밋하지 않음
- `templates/role-reviewer.md` — Reviewer: 검사 후 APPROVE 시 커밋+푸시

## Templates & Skills
- `templates/plan.md` — work plan format
- `templates/handoff.md` — session handoff format
- `templates/bug-fix.md` — bug fix workflow format
- `skills/bug-fix/` — 7-step bug fix workflow
- `skills/code-review/` — code review checklist

## Rules (자동 적용)
- `.claude/rules/api.md` — API/DB 규칙
- `.claude/rules/frontend.md` — UI 규칙
- `.claude/rules/testing.md` — 테스트 규칙
- `.claude/rules/git.md` — 커밋, 브랜치 규칙

## Outputs
- `outputs/plans/` — Planner 산출물
- `outputs/reviews/` — Reviewer 산출물
- `outputs/archive/` — 해결된 과거 문서
