---
name: code-review
description: Review code changes for correctness, security, and architecture
version: 2.0.0
---

# Code Review Skill

## Goal
Review code changes and provide actionable feedback organized by severity.

## Input Required
- The diff or files to review
- Context about what the change is supposed to do

## Steps

### 1. Understand Intent
- Read the Task description or plan
- Understand what problem the change solves

### 2. Read the Diff
- Read all changed files in full
- Note the scope of changes

### 3. Check for Issues (in priority order)

#### Critical (must fix)
- Security: hardcoded secrets, auth bypass
- Data loss risk
- Missing error handling on external calls
- Broken functionality (wrong routes, broken API)

#### Important (should fix)
- Architecture rule violations (see .claude/rules/)
- Missing tests for new behavior
- Hardcoded values (config, URLs, colors)

#### Minor (nice to fix)
- Naming improvements
- Code organization
- Documentation gaps

### 4. Report Format
```
## Review Report

**Overall:** APPROVE / REQUEST_CHANGES / NEEDS_DISCUSSION

### Critical
- [file:line] description + suggested fix

### Important
- [file:line] description + suggested fix

### Minor
- [file:line] description

### Good
- What was done well (reinforce good patterns)
```

### 5. Verify
- Run lint/analyze and check the results
- Run tests and check the results
- Compare report findings against actual tool output

## Verdict Criteria
- Any Critical → REQUEST_CHANGES
- Only Important → defer to Developer's judgment
- Only Minor → APPROVE
