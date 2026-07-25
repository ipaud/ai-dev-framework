---
name: loop-engineering
description: Structure any unit of work as a loop sized to the task (trivial / change / feature). Use at the start of every piece of work to pick the tier, run the right depth, and record the loop. Pastes real gate output before closing.
allowed-tools: Read Grep Glob Edit Write Bash(git status:*)
---

# loop-engineering

## Purpose
Turn a task into a right-sized loop that ends in one focused commit, with objective gates — not
vibes — deciding done.

## Trigger
The start of any work. Before writing code, pick the tier.

## Procedure
1. **Pick the tier.** When unsure, size up.

   | Tier | When | Shape |
   |---|---|---|
   | trivial | one obvious, reversible change | do → run the relevant gate → commit |
   | change | bounded change to existing behavior | plan briefly → implement → simplify → gate → commit |
   | feature | new behavior or crosses a boundary | the 9 steps below |

2. **Run the tier.**
   - *trivial / change* collapse the feature steps to the ones that matter; always Validate and commit.
   - *feature* runs the full depth:
     1. **Goal** — one sentence; how you'll know it's done.
     2. **Not-doing** — explicit out-of-scope.
     3. **Delete Before Create** — answer the four questions (see ponytail); log them.
     4. **Plan** — the steps.
     5. **Implement** — the change.
     6. **Simplify** — the ponytail after-pass.
     7. **Validate** — run the adapter's gate commands for this tier; paste the **real output**.
     8. **Reflect** — lessons → `lessons.md`, decisions → `decisions.md`, risks → `known-issues.md`.
     9. **Score** — optional advisory axes → `score.md`.
3. **Record the loop** in `adf-memory/loops/NNNN-slug.md` (copy `0000-template.md`). This file plus
   `project.md` is the durable progress record — what survives compaction and session boundaries
   (see the `PreCompact` / `SessionEnd` hooks).
4. **Close** only when the adapter's objective gates are green **and** the working tree is clean
   and mergeable (no stray uncommitted changes, no unresolved conflicts). Then one conventional
   commit.

## Output
A loop file at `adf-memory/loops/NNNN-slug.md` with real gate output in Validate, a clean working
tree, and one commit.

## Anti-patterns
- Sizing down when unsure.
- Closing on a summary instead of pasted gate output.
- More than one goal in a loop, or more than one loop in a commit.
- Treating the AI Score as the exit condition. Gates decide; the score is advisory.
