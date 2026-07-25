---
name: repo-analysis
description: Learn from a reference repository under references/ without copying its code. Use when a repo is added to references/ or prior art is needed. Output is a structured read — ideas to adopt, problems to avoid — never copied code.
allowed-tools: Read Grep Glob Edit Write
---

# repo-analysis

## Purpose
Extract ideas and warnings from an external repo so the project can reuse the *approach*, not the
code.

## Trigger
A repository is placed under `references/`, or the task needs prior art before designing.

## Procedure
1. **Map** — what the repo is, its entry points, and how it is organized.
2. **Dependencies** — what it leans on, and what that buys it.
3. **Ideas** — approaches worth adopting, described in our own terms.
4. **Problems** — what it gets wrong or pays for; what to avoid.
5. **License** — record the license and whether it constrains us. If unclear, treat as
   all-rights-reserved and adopt ideas only.
6. **Recommend** — a short list: adopt / adapt / avoid, each with a one-line reason.

## Output
A written analysis with the six headings above, appended to the loop file or a research doc.
**Ideas, never copied code.**

## Anti-patterns
- Pasting source from the reference into the project.
- Adopting an approach without checking the license.
- Summarizing the repo instead of deciding what we adopt or avoid.
