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
