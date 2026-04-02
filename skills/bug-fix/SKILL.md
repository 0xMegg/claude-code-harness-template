---
name: bug-fix
description: Structured bug fix workflow — reproduce, diagnose, fix, verify
version: 1.0.0
---

# Bug Fix Skill

## Goal
Fix a reported bug with minimal blast radius and full verification.

## Input Required
- Bug description (what's broken)
- Reproduction steps (or enough info to find them)

## Steps

### 1. Understand
- Read the bug report
- Identify the affected area (files, components, endpoints)
- Read the relevant code

### 2. Reproduce
- Follow reproduction steps
- Confirm the bug exists
- Note the exact error message or incorrect behavior

### 3. Diagnose
- Form a hypothesis about the root cause
- Trace the code path from trigger to symptom
- Check git blame for recent changes in the area
- If hypothesis is wrong, form a new one (max 3 attempts before escalating)

### 4. Plan the Fix
- Write a plan using `templates/bug-fix.md`
- Define scope: which files to change, which to avoid
- Present the plan before implementing

### 5. Implement
- Make the smallest change that fixes the bug
- Don't refactor surrounding code
- Don't fix other bugs you notice (note them for later)

### 6. Verify
- Write a regression test that fails without the fix
- Run all tests in the affected area
- Run the full test suite
- Manually verify the reproduction steps no longer reproduce

### 7. Handoff
- Update `handoff/latest.md`
- Note what changed, why, and any remaining risk

## Common Pitfalls
- Fixing the symptom instead of the root cause
- Changing too many files at once
- Forgetting to add a regression test
- Not checking for similar bugs in related code
