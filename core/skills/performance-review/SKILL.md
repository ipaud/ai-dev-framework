---
name: performance-review
description: Review agnostic performance axes — hot paths, allocations in loops, blocking on async, startup/footprint, memory, I/O — against the adapter's budget. Use for perf-sensitive or hot-path changes. Output is measured findings vs budget.
allowed-tools: Read Grep Glob
---

# performance-review

## Purpose
Find where the change spends time and resources, and check it against the budget — with
measurements, not guesses.

## Trigger
A perf-sensitive change, a hot-path change, or a regression report.

## Procedure
1. **Hot paths** — what runs often or per-frame/per-request; is the change on one?
2. **Allocations in loops** — repeated allocation inside hot loops; can it be hoisted or reused?
3. **Blocking on async** — synchronous work on an async/critical path; move it off.
4. **Startup / footprint** — effect on startup time and shipped size vs the adapter budget.
5. **Memory** — growth, retention, leaks under sustained use.
6. **I/O** — chatty or unbatched I/O; N+1 patterns; missing caching of expensive work.
7. **Measure** — take real numbers; compare to the adapter's thresholds.

## Output
Findings as **measured value vs budget** (e.g. "startup 1.8s, budget <1.5s"). Each over-budget
item becomes a loop. If the adapter sets no budget for an axis, say so — don't invent a threshold.

## Anti-patterns
- Optimizing without measuring (premature optimization).
- Inventing thresholds the adapter doesn't define.
- Micro-optimizing a cold path while a hot path bleeds.
