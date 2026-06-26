---
name: ux-review
description: Heuristic review of navigation, feedback, error/loading/empty states, and consistency. Use for any UI change. Output is issues plus suggested fixes. Agnostic — no framework assumptions.
---

# ux-review

## Purpose
Catch the UX gaps a user hits but a happy-path demo hides — missing states, silent failures,
inconsistency.

## Trigger
Any UI change.

## Procedure
1. **Navigation** — can the user tell where they are, where they can go, and how to get back?
2. **Feedback** — does every action produce a visible result? Is progress shown for slow work?
3. **Error states** — are failures surfaced clearly, with a recovery path? No dead ends.
4. **Loading states** — is waiting communicated, not a frozen or blank screen?
5. **Empty states** — does first-run / no-data guide the user instead of looking broken?
6. **Consistency** — do similar things look and behave alike across the surface?

## Output
A list of issues, each with location, the broken expectation, and a suggested fix. Severity by
how often and how badly a real user hits it.

## Anti-patterns
- Reviewing only the happy path.
- Treating taste as a defect — flag what breaks the user's task, not personal preference.
- Prescribing a specific framework's widget; describe the behavior the state needs.
