---
name: bug-fix
description: Structured bug fix workflow — reproduce, diagnose, fix, verify
version: 2.0.0
---

# Bug Fix Skill

## Goal
Fix the bug with minimal blast radius and full verification.

## Input Required
- Bug description (what is broken)
- Reproduction steps (or enough info to find them)

## Steps

### 1. Understand
- Read the bug report
- Identify the affected area (files, modules, endpoints)
- Read the relevant code

### 2. Reproduce
- Follow reproduction steps
- Record the exact error message or incorrect behavior

### 3. Diagnose
- Form a root cause hypothesis
- Trace the code path from trigger to symptom
- Check git blame for recent changes
- If hypothesis is wrong, form a new one (max 3 attempts, then escalate to human)

### 4. Plan
- Write a fix plan using `templates/bug-fix.md`
- Define scope: files to change vs. files to avoid
- Present the plan before implementing

### 5. Implement
- Make the smallest change that fixes the bug
- Do not refactor surrounding code
- If you find other bugs, note them in handoff (don't fix now)

### 6. Verify
- [ ] `{{LINT_CMD}}` passes with no warnings
- [ ] Related tests pass
- [ ] Regression test added
- [ ] Project architecture rules followed (see .claude/rules/)
- [ ] Manual reproduction no longer triggers the bug
- [ ] {{VERIFY_CHECK_1}}
- [ ] {{VERIFY_CHECK_2}}

### 7. Handoff
- Update handoff/latest.md
- Record what changed, why, and any remaining risk

## Common Pitfalls
- Fixing the symptom instead of the root cause
- Changing too many files at once
- Forgetting to add a regression test
- Mixing scope — doing refactoring alongside the fix
- {{PITFALL_1}}
- {{PITFALL_2}}
