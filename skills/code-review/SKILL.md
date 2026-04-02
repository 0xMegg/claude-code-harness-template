---
name: code-review
description: Review code changes for correctness, security, and quality
version: 1.0.0
---

# Code Review Skill

## Goal
Review code changes and provide actionable feedback organized by severity.

## Input Required
- The diff or files to review
- Context about what the change is supposed to do

## Steps

### 1. Understand Intent
- Read the PR description or task context
- Understand what problem the change solves

### 2. Read the Diff
- Read all changed files
- Note the scope of changes

### 3. Check for Issues (in priority order)

#### Critical (must fix)
- Security vulnerabilities (injection, XSS, auth bypass)
- Data loss risks
- Breaking changes to public APIs
- Missing error handling on external calls

#### Important (should fix)
- Logic errors or edge cases
- Missing tests for new behavior
- Performance issues (N+1 queries, unnecessary re-renders)
- Inconsistency with project conventions

#### Minor (nice to fix)
- Naming improvements
- Code organization
- Documentation gaps

### 4. Report Format
```
## Review Summary
**Overall**: APPROVE / REQUEST_CHANGES / NEEDS_DISCUSSION

### Critical
- [file:line] description + suggested fix

### Important
- [file:line] description + suggested fix

### Minor
- [file:line] description

### Good Stuff
- What was done well (reinforce good patterns)
```

### 5. Verify Fixes
- If changes are made, re-review only the changed parts
- Confirm critical issues are resolved

## Common Pitfalls
- Nitpicking style while missing logic bugs
- Reviewing without understanding the context
- Suggesting rewrites instead of targeted fixes
