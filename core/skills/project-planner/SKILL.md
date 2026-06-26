---
name: project-planner
description: Maintain the backlog, roadmap, prioritization, and cross-task dependencies; recommend the next loop. Use for planning and prioritization. Evolving, not static. Writes roadmap.md.
---

# project-planner

## Purpose
Keep an honest, ordered view of what's next and why, so each loop starts on the right thing.

## Trigger
Planning a sprint, finishing a loop (propose the next), or when priorities shift.

## Procedure
1. **Backlog** — capture work as candidate loops, each with a goal and a rough tier.
2. **Prioritize** — order by value, risk, and unblocking power; record the reason, not just the rank.
3. **Dependencies** — map cross-task ordering ("X must land before Y"); surface hidden blockers.
4. **Right-size** — flag items too big for one loop; split them.
5. **Recommend next** — name the single next loop with a one-line rationale.
6. **Write it down** — update `roadmap.md` (Now / Next / Later, dependencies, recommended next).

## Output
An updated `adf-memory/roadmap.md` and a clear "next loop" recommendation. The roadmap evolves
every planning loop — it is never a static document.

## Anti-patterns
- A frozen roadmap that no longer matches reality.
- Prioritizing without recording why.
- A "next loop" too big to finish in one commit.
