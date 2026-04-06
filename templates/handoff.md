# Session Handoff

> 이 파일은 **overwrite** 모델이다.
> 각 Role 전환 시 현재 상태만 남기고, 이전 핸드오프는 `outputs/archive/`로 이동한다.
> 50줄 이내를 유지한다. Context reset 환경에서 핸드오프는 최소 계약이어야 한다.

## Current State
- Task: [Task N — name]
- Phase: [Plan / Develop / Review / Done]
- Date: [date]

## Last Action
- [가장 최근 Role이 수행한 핵심 결과 1-3줄]

## Files Changed
- `[repo/file path]` — [reason]
  (multi-repo: repo 접두사 사용, e.g., `backend/src/api/auth.ts`)

## Verification Status
- Lint: PASS / FAIL
- Test: PASS / FAIL / N/A
- Live: PASS / FAIL / N/A

## Next Step
- [다음 Role이 해야 할 일, 1-2줄]

## Carry Over
- [이번 cycle에서 발견되었지만 다음 Task로 미룬 이슈, 없으면 "none"]

## Plan & Review Locations
- Plan: outputs/plans/task-N-plan.md
- Verify: outputs/plans/task-N-verify.md
- Review: outputs/reviews/task-N-review.md (있으면)
