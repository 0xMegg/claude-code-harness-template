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

## Live Verification (UI/API 태스크)
Reviewer가 실제 실행 중인 앱에서 직접 검증하는 항목.
정적 코드 리뷰만으로는 발견하지 못하는 런타임 버그를 잡기 위함.
1. 개발 서버 실행: `{{DEV_CMD}}`
   - Multi-repo: 해당 Slice가 수정한 repo의 서버를 실행 (e.g., backend `{{BACKEND_DEV_CMD}}`, frontend `{{FRONTEND_DEV_CMD}}`)
2. Happy path:
   - [ ] [정상 시나리오 — e.g., "유효한 이메일/비밀번호로 가입 → 메인 화면 이동"]
3. Edge cases:
   - [ ] [엣지 1 — e.g., "빈 폼 제출 시 에러 메시지 표시"]
   - [ ] [엣지 2 — e.g., "이미 존재하는 이메일로 가입 시도"]
4. API 엔드포인트 (해당 시):
   - [ ] [curl/Postman으로 정상 요청 확인]
   - [ ] [잘못된 입력으로 에러 응답 확인]

순수 로직/리팩터링 태스크는 이 섹션을 "N/A — 순수 로직 변경"으로 표기.

## Quality Criteria (디자인/크리에이티브 태스크)
기능적으로 동작하더라도 품질이 미달이면 ITERATE verdict.
해당하지 않는 태스크는 이 섹션을 생략.

1-10점, 가중치:
- Design Quality (×3): 시각 위계, 간격, 타이포그래피 일관성
- Originality (×3): 제네릭/템플릿 패턴 회피, 고유한 캐릭터
- Craft (×2): 디테일 폴리시, 트랜지션, 반응성
- Functionality (×2): 정확성, 엣지 케이스 처리

가중 합계 70/100 미만 → ITERATE (구체적 개선 타겟 필수)

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
