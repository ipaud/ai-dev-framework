---
name: debugging
description: Reproduce, isolate, hypothesize, apply the minimal fix, add a regression test, and record the lesson. Use for a reported bug or failing behavior. Output is root cause plus fix plus a lessons entry.
allowed-tools: Read Grep Glob Edit Write
---

# debugging

## Purpose
Fix the actual cause once, and leave a test so it can't come back.

## Trigger
A reported bug, a failing test, or behavior that doesn't match intent.

## Procedure
1. **Reproduce** — a reliable, minimal repro. If you can't reproduce it, you can't claim a fix.
2. **Isolate** — narrow to the smallest code path that still shows the bug (bisect, log, shrink input).
3. **Hypothesize** — state the suspected cause as a falsifiable claim; confirm before fixing.
4. **Minimal fix** — change the cause, not the symptom; smallest change that holds (ponytail).
5. **Regression test** — a test that fails before the fix and passes after.
6. **Lesson** — root cause and the behavior change → `lessons.md`.

## Output
Root cause (one paragraph), the fix, the regression test, and a `lessons.md` entry. Gate green.

## Anti-patterns
- Patching the symptom while the cause survives.
- "Fixing" without a repro, or without a test that proves it.
- A fix larger than the bug.
