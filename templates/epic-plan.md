# Epic Plan

## Epic
[Epic number] — [Epic name]

## Goal
[What this feature looks like when fully complete, 2-3 sentences]

## Context
- User need: [what problem this solves for the user]
- Related docs: [design docs, specs, references]
- Dependencies: [external APIs, DB changes, other epics]

## Stages & Slices
Break the epic into independently deliverable slices, grouped into stages.
- **Stages** run sequentially (Stage 2 waits for Stage 1 to finish).
- **Slices within the same Stage** run in parallel and must NOT modify the same files or depend on each other.

If parallelism is not needed, put all slices in a single stage or omit Stage headings entirely (backward compatible — treated as sequential).

### Stage 1
#### Slice 1: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Depends on:** (none)
- **Done when:** [specific acceptance criteria]

#### Slice 2: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Depends on:** (none)
- **Done when:** [specific acceptance criteria]

### Stage 2
#### Slice 3: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Depends on:** Stage 1
- **Done when:** [specific acceptance criteria]

### Stage N
#### Slice N: [name]
- **What:** [what this slice delivers]
- **Files:** [expected files to create/modify]
- **Depends on:** [Stage number or "none"]
- **Done when:** [specific acceptance criteria]

## Slicing Principles
- Each slice is independently testable and reviewable
- Data layer before UI (repository → provider → widget)
- Shared/core changes before feature-specific ones
- No slice should touch more than ~5 files

### Parallel Rules (same Stage)
- Slices in the same Stage must NOT modify the same files
- Slices in the same Stage must NOT have data dependencies on each other
- Each parallel slice must have independent tests
- When in doubt, put slices in separate Stages (sequential is always safe)

## Epic Acceptance Criteria
- [ ] All slices completed and reviewed
- [ ] Lint/analyze passes
- [ ] Tests pass
- [ ] [end-to-end user flow description]

## Open Questions
- [Undecided items that may affect slice scope]

## Rollback Strategy
If the epic must be abandoned mid-way: [which slices are safe to keep, which to revert]
