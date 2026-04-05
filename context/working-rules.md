# Working Rules

## Work Principles
1. **Read before write** — understand existing code before changing it
2. **Feature-local first** — make changes inside the owning feature/module first; touch shared layers only when necessary
3. **Smallest change** — do only what completes the task, nothing more
4. **No scope creep** — if you notice unrelated cleanup or refactoring, log it as a separate task

## Session Protocol (3-Role Workflow)
Each session performs exactly one role. When given a role file (`templates/role-*.md`), follow only that role.

1. **Planner** (read-only): read handoff → analyze code → write `outputs/plans/task-N-plan.md` → update handoff
2. **Developer** (implement only): read handoff → follow plan → lint + test → update handoff (do NOT commit)
3. **Reviewer** (verify only): read handoff → inspect code → write `outputs/reviews/task-N-review.md` → commit + push on APPROVE → update handoff

If no role is specified (general session):
1. Start: read `handoff/latest.md` for current state
2. Execute: make changes, run lint/analyze
3. Verify: confirm tests pass
4. Handoff: update `handoff/latest.md`

## Session Management
- **Continue (`--continue`):** same task, same context — pick up where you left off
- **Resume (`--resume`):** browse past sessions and select one to continue
- **Fork (`--fork-session`):** branch off into a different direction from the current session
- **Worktree (`--worktree`):** parallel implementation on separate files — never edit the same file in two sessions
- When the session gets long, run `/compact` before critical context is lost
- After a direction change, prefer `--fork-session` over continuing in a polluted context

## Compact Rules
When running `/compact`, always preserve:
- Last modified files and why
- Test results (pass/fail/not run)
- Discarded alternatives and reasons
- The single next action for the next turn
- Risk points needing human review
- Current Task number and plan location

## Communication
- If uncertain about scope, ask before implementing
- If 3+ different approaches fail, stop and discuss
- Flag security concerns immediately
- State assumptions explicitly

## Quality Gates (before declaring done)
- [ ] Lint/Analyze passes
- [ ] Related tests pass (if any)
- [ ] Changes are within the requested scope
- [ ] Handoff notes updated

## Token & Context Management

### 핵심 원칙
토큰은 비용이면서 집중력(attention budget) 문제다.
절약보다 집중 — 필요한 것만 조합한다.

### 컨텍스트 구성 (항상 vs 필요 시)
| 항상 상주 | 필요 시만 열기 |
|-----------|---------------|
| CLAUDE.md | 긴 참고 문서, 사례집 |
| 짧은 공통 규칙 (rules/) | 세부 라이브러리 레퍼런스 |
| 핵심 명령, 프로젝트 구조 | 오래된 설계 문서 |
| handoff/latest.md | outputs/archive/ |

### 토큰 비용이 커지는 5가지 구간
1. 너무 긴 CLAUDE.md와 상시 규칙 파일
2. 범위가 모호한 프롬프트 ("알아서 해 줘")
3. 긴 세션 누적 (작업 경계 바뀌면 세션도 끊기)
4. 과도한 도구 출력 (테스트 전체 로그, 검색 결과 수백 줄)
5. 한 세션에서 너무 많은 역할 동시 수행

### 모델 사용 분리
- 강한 모델 (Opus): 설계, 논문 이해, 큰 구조 판단
- 균형형 모델 (Sonnet): 구현, 검색, 파일 확인, 단순 수정

### 세션 분리 기준
- 작업 경계가 바뀌면 세션도 끊기
- /compact → 같은 세션 이어가기 (빠르지만 세션 피로 완전 제거 못함)
- 리셋 (새 세션) → handoff와 plan이 더 단단해야 함 (깨끗한 출발점)
- 압축 뒤에는 바로 이어서 밀어붙기보다, 현재 task plan과 관련 파일을 다시 읽고 시작

### MCP 상주 비용
- 도구 설명과 출력이 컨텍스트를 미리 차지
- 자주 안 쓰는 MCP는 꺼두기
- 같은 작업이라도 무거운 통합보다 필요 시 CLI 호출이 가벼울 수 있음

### CLAUDE.md 관리
- 같은 실수가 반복되면 규칙에 반영
- 이미 잘 지키는 상식까지 길게 적지 않음
- 규칙 파일은 많을수록 좋은 설명서가 아니라, 계속 틀리는 지점을 줄여주는 짧은 운영 문서

## Evaluation Loop
매 Task 완료 후 `templates/evaluation.md` 형식으로 기록.
반복되는 실패 패턴이 발견되면:
1. `.claude/rules/gotchas.md`에 Known Pitfall로 추가
2. 해당 Skill의 Common Pitfalls에 추가
3. 필요 시 hook으로 자동 감지 추가

5가지 지표를 계속 비교:
- 성공률, 사람 수정량, 시간, 토큰/비용, 실패 유형
