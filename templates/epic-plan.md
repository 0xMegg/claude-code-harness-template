# Epic Plan

## Epic
[Epic number] — [Epic name]

## Goal
[What this feature looks like when fully complete, 2-3 sentences]

## Context
- User need: [what problem this solves for the user]
- Related docs: [design docs, specs, references]
- Dependencies: [external APIs, DB changes, other epics]

## Slices
Break the epic into independently deliverable slices. Each slice becomes one Task in the Planner → Developer → Reviewer cycle.

Order matters — earlier slices should not depend on later ones.

### Slice 1: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Done when:** [specific acceptance criteria]

### Slice 2: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Done when:** [specific acceptance criteria]

### Slice 3: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Done when:** [specific acceptance criteria]

### Slice N: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Done when:** [specific acceptance criteria]

## Slicing Principles
- Each slice is independently testable and reviewable
- Data layer before UI (repository → provider → widget)
- Shared/core changes before feature-specific ones
- No slice should touch more than ~5 files

## Epic Acceptance Criteria
- [ ] All slices completed and reviewed
- [ ] Lint/analyze passes
- [ ] Tests pass
- [ ] [end-to-end user flow description]

## Open Questions
- [Undecided items that may affect slice scope]

## Rollback Strategy
If the epic must be abandoned mid-way: [which slices are safe to keep, which to revert]
