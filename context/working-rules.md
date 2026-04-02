# Working Rules

## Work Principles
1. **Read before write** — 수정 전에 기존 코드를 먼저 읽는다
2. **Feature-local first** — 변경은 해당 feature/module 안에서 먼저, shared는 꼭 필요할 때만
3. **Smallest change** — 작업을 완료하는 가장 작은 변경만 한다
4. **No scope creep** — 옆에 보이는 정리/리팩터링은 별도 작업으로 분리

## Session Protocol (3-Role Workflow)
각 세션은 하나의 역할만 수행한다. 역할 파일(`templates/role-*.md`)을 지시받으면 해당 역할만 따른다.

1. **Planner** (읽기 전용): handoff 읽기 → 코드 분석 → `outputs/plans/task-N-plan.md` 작성 → handoff 업데이트
2. **Developer** (구현 전용): handoff 읽기 → plan 따라 구현 → lint + test → handoff 업데이트 (커밋 안 함)
3. **Reviewer** (검증 전용): handoff 읽기 → 코드 검사 → `outputs/reviews/task-N-review.md` 작성 → APPROVE 시 커밋+푸시 → handoff 업데이트

역할 지시 없이 일반 세션일 경우:
1. Start: `handoff/latest.md` 읽어서 현재 상태 파악
2. Execute: 변경 후 lint/analyze 실행
3. Verify: 테스트 통과 확인
4. Handoff: `handoff/latest.md` 업데이트

## Communication
- 범위가 불확실하면 구현 전에 먼저 질문
- 3번 이상 다른 접근을 시도해도 안 되면 멈추고 논의
- 보안 관련 우려는 즉시 보고
- 가정을 명시적으로 서술

## Quality Gates (완료 전 체크)
- [ ] Lint/Analyze 통과
- [ ] 관련 테스트 통과 (있다면)
- [ ] 변경이 요청 범위 안에 있음
- [ ] Handoff 노트 업데이트됨
