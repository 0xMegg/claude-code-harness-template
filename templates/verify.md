# Verification Plan

## Task
[Task N] — [Task name]

## Completion Criteria
모델과 사람이 같은 끝점을 보게 만드는 좌표.
- [ ] [기능적 완료 기준 1]
- [ ] [기능적 완료 기준 2]

## Automated Checks
순서대로 실행. 이전 단계 실패 시 다음 단계 진행하지 않음.
1. Lint/Analyze: `{{LINT_CMD}}`
2. Type check: `{{TYPECHECK_CMD}}`
3. Targeted test: `{{TEST_SINGLE_CMD}}` (변경 영역만)
4. Full test: `{{TEST_CMD}}`
5. Build: `{{BUILD_CMD}}`

## Manual Checks
- [ ] [수동 검증 항목 — e.g., "빈 폼 제출 시 에러 메시지 확인"]
- [ ] [엣지 케이스 — e.g., "null/empty 입력으로 테스트"]
- [ ] [화면 검증 — e.g., "스크린샷 확인" or "로컬 UI에서 직접 확인"]

## Constraints
- 테스트 코드를 통과시키기 위해 테스트를 수정하지 말 것
- 다음 파일은 수정 금지: [보호 파일 목록]
- 화면 검증까지 끝나야 종료할 것

## Rollback Point
- Revert 대상: [특정 파일 또는 git revert 전략]
- 유지 가능: [롤백해도 남겨도 되는 파일]

## Report
검증 완료 후 아래 형식으로 기록:
- What changed:
- What passed:
- What failed:
- What needs human confirmation:
- Confidence level: HIGH / MEDIUM / LOW
