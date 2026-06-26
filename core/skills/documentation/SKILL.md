---
name: documentation
description: Keep the loop log, architecture.md, roadmap.md, decisions.md, known-issues.md, and README current. Use at loop close, release, and memory update. Output is doc diffs only for what actually changed.
---

# documentation

## Purpose
Keep memory and docs matching reality, so the next session reads truth — without busywork.

## Trigger
Loop close, release notes, or any change that makes existing docs wrong.

## Procedure
1. **Loop log** — the loop file records Goal, real Validate output, Ponytail deltas, Reflect.
2. **architecture.md** — update if modules, boundaries, or data flow changed.
3. **roadmap.md** — reflect what shipped and what's now next (with project-planner).
4. **decisions.md** — append any decision the loop made; link an ADR for weighty ones.
5. **known-issues.md** — add new risks/deferrals; close resolved ones.
6. **README** — update only if user-facing usage or setup changed.
7. **Diff discipline** — touch only what actually changed. No doc churn for its own sake.

## Output
Doc diffs limited to what changed this loop. Nothing rewritten that didn't move.

## Anti-patterns
- Rewriting a doc that didn't change.
- Closing a loop with a stale loop log or empty Validate.
- Documenting intent that the code doesn't yet match.
