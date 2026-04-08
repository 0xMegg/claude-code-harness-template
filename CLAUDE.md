# Project Contract

## Project
- Name: Claude Code Harness
- Type: Development Tooling / Meta-Project
- Stack: Bash, Markdown, Claude Code Skills

## Build & Test Commands
- Build template: `bash scripts/build-template.sh`
- Harness report: `bash scripts/harness-report.sh`
- Run harvest: `bash scripts/run-harvest.sh`
- Lint: `shellcheck scripts/*.sh`

## Folder Boundaries
- Source code (template source): `src/`
- Build output: `outputs/template/`
- Harvest data: `harvest/`
- Do NOT modify: `.env`, `outputs/template/` (auto-generated), `harvest/.seen.json`

## Architecture
- Meta-project: 하네스를 하네스로 관리하는 자기참조 구조
- src/ = 배포용 템플릿 소스 ({{플레이스홀더}} 포함)
- outputs/template/ = src/에서 빌드된 결과물 (사용자에게 배포)
- harvest/ = self-improvement pipeline 데이터
- 7-Element Harness: Permissions, Validation, Execution Mode, State, Decision Trace, External Integration, Self-Improvement Loop

## Work Protocol
1. Read the relevant code before modifying
2. Keep changes feature-local first
3. Run lint/analyze after every change
4. Make the smallest change that completes the task
5. Update `handoff/latest.md` with what changed and what's next
6. After modifying src/ or root harness files, run `bash scripts/build-template.sh`

## Restrictions
- Never commit secrets, API keys, or .env files
- Never run `rm -rf` on project directories
- Never force push to main/master
- Never add dependencies without stating the reason
- Never do repo-wide refactor without explicit request
- Never modify outputs/template/ directly — always edit src/ and rebuild

## References
- `context/` — project background, working rules, decision log
- `context/about-me.md` — project description
- `context/working-rules.md` — 3-Role workflow + self-improvement loop
- `context/harvest-policy.md` — harvest auto-apply vs manual approval rules
- `handoff/latest.md` — current state and task queue
- `docs/harvest-guide.md` — self-improvement pipeline explanation
- `src/` — template source (edit here, build to outputs/template/)

## Self-Improvement (Harvest Module)
- `harvest/config.json` — 수집 소스, 임계값, 스케줄 설정
- `context/harvest-policy.md` — 자동 적용 vs 수동 승인 정책
- `/harvest` — 전체 파이프라인 실행
- `/harvest scan` — 수집만
- `/harvest add <URL/설명>` — 수동 입력
- `/harvest judge` — baseline 측정 + autoresearch
- `/harvest status` — 현황 확인

## 3-Role Workflow
- `/plan` — Planner: read-only, writes plans to `outputs/plans/`
- `/develop` — Developer: implements + verifies, does NOT commit
- `/review` — Reviewer: reviews, commits + pushes on APPROVE
- Tasks modifying 3+ files → Planner must produce a plan first

## Rules (auto-applied)
- `.claude/rules/api.md` — API/DB rules
- `.claude/rules/frontend.md` — UI rules
- `.claude/rules/testing.md` — testing rules
- `.claude/rules/git.md` — commit and branch rules
- `.claude/rules/gotchas.md` — project-specific pitfalls
