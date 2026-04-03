# Verification Plan

## Task
[Task N] — [Task name]

## Automated Checks
- [ ] Lint/Analyze: `{{LINT_CMD}}`
- [ ] Targeted test: `{{TEST_SINGLE_CMD}}` (specific to changed area)
- [ ] Full test: `{{TEST_CMD}}`
- [ ] Build: `{{BUILD_CMD}}`

## Manual Checks
- [ ] [Manual verification item — e.g., "submit empty form in local UI"]
- [ ] [Edge case — e.g., "test with empty/null input"]

## Rollback Point
- Revert: [specific files or `git revert` strategy]
- Safe to keep: [files that can stay even if rollback is needed]

## Report
After verification, fill in:
- What passed:
- What failed:
- What needs human confirmation:
