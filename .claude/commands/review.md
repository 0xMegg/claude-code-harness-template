Follow the Reviewer role defined in templates/role-reviewer.md exactly.

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
