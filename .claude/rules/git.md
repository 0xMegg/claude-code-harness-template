# Git Rules

## Commits:
- 메시지 형식: `type: Task N — 변경 요약` (feat, fix, refactor, test, docs, chore)
  - 예: `fix: Task 3 — 에러 처리 추가`
  - 예: `refactor: Task 5 — inline 로직 분리`
- Task 하나당 커밋 하나 (논리적 단위)
- .env, 시크릿, build output 절대 커밋하지 않기
- 커밋 전 lint/analyze 통과 확인
- 커밋은 Reviewer만 한다 (APPROVE 판정 후)

## Branches:
- Solo 개발: main에서 직접 작업 + 커밋+푸시 허용
- 협업 시: Feature branch (`feat/short-description`) → PR → merge
- 대규모 변경 시에는 solo라도 브랜치 추천

## Pull Requests (협업 시):
- PR title matches commit convention
- 변경 내용과 이유를 설명에 포함
- 셀프 리뷰 후 요청
