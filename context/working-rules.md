# Working Rules

## Work Principles
1. **Read before write** — understand existing code before changing it
2. **Small changes, fast verification** — change one thing, test it, then move on
3. **Explicit over clever** — readable code beats clever code
4. **Fix the cause, not the symptom** — investigate root causes before patching

## Session Protocol
1. Start: read `handoff/latest.md` to understand current state
2. Plan: write what you'll do before doing it (use `templates/plan.md`)
3. Execute: make changes, run tests after each change
4. Verify: all tests pass, build succeeds, no lint errors
5. Handoff: update `handoff/latest.md` with what changed and what's next

## Communication
- If uncertain about scope, ask before implementing
- If a task takes more than 3 approaches, pause and discuss
- Flag security concerns immediately
- State assumptions explicitly

## Quality Gates (before declaring "done")
- [ ] Tests pass
- [ ] Build succeeds
- [ ] No new lint warnings
- [ ] Changes are within the requested scope
- [ ] Handoff notes updated
