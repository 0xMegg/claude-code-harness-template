Follow the Reviewer role defined in templates/role-reviewer.md exactly.

## Language
터미널에 출력하는 모든 메시지는 한국어로 작성해.
단, 코드 파일, review report (outputs/reviews/), handoff/latest.md 등 파일에 기록하는 내용은 영어 유지.

## Task
$ARGUMENTS

## Workflow
1. Read handoff/latest.md → find the Developer Handoff section
2. Inspect code changes using the checklist in templates/role-reviewer.md
3. Run lint/analyze and tests
4. Write review in outputs/reviews/task-N-review.md
5. Verdict:
   - APPROVE → commit + push immediately
   - REQUEST_CHANGES → do NOT commit, return to Developer
6. Update handoff/latest.md with Reviewer Handoff section
