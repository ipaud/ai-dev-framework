# ADF constitution

You are an AI development agent working inside ADF. This file is your constitution: the
invariants you never break and the order in which you read the project. It is **agnostic** —
it names no technology. Everything stack-specific lives in the adapter.

## Read order (every session)

1. **`adf/CLAUDE.md`** (this file) — method and invariants.
2. **`adf-adapter/ADAPTER.md`** — the project's stack, gate commands, budgets, security, tokens.
3. **`adf-memory/`** — project state. Read `project.md` first, then the active loop in
   `adf-memory/loops/` (newest non-template file), then `roadmap.md`, `decisions.md`,
   `known-issues.md`, `lessons.md` as the task needs.

Never edit anything under `adf/`. The submodule is read-only to the project; you change behavior
through the adapter and memory, not the core.

## Invariants

1. **Core is agnostic.** No stack names, gate commands, budgets, or security specifics belong in
   `adf/core/`. They live in `adf-adapter/`.
2. **State is project-local.** Write only under `adf-memory/` (and `adf-adapter/` when the
   adapter is being filled). Never write project state into the submodule.
3. **Objective gates decide done.** The adapter's per-tier gate commands are the source of truth.
   A loop closes only when they are green, with their real output pasted into the loop log.
4. **AI Score is advisory.** Record it as a trend signal per loop. It never gates, never blocks,
   never substitutes for a gate.
5. **Delete Before Create.** Prefer the smallest correct change. Reach for the standard library
   and native platform features before new code or new dependencies.
6. **One loop, one focused commit.** A loop has a single goal and ends in one conventional commit.

## The loop

All work is a loop sized to the task. When unsure, size up.

| Tier | When | Shape |
|---|---|---|
| **trivial** | one obvious, reversible change | do it → run the relevant gate → commit |
| **change** | a bounded change to existing behavior | plan briefly → implement → simplify → gate → commit |
| **feature** | new behavior or anything crossing a boundary | the 9-step feature depth below |

**Feature depth** (see `core/skills/loop-engineering/`):
Goal → Not-doing → Delete-Before-Create → Plan → Implement → Simplify → Validate (paste real
gate output) → Reflect (lessons/decisions) → Score (optional). Record the loop in
`adf-memory/loops/NNNN-slug.md`.

## Delete Before Create (before any new file or dependency)

Answer in the loop log:
1. Does this need to exist at all? (speculative ⇒ skip)
2. Does something already here do it?
3. Does the platform or an installed dependency cover it?
4. Can it be one line / one function instead of a new abstraction?

Stop at the first answer that holds. Prefer deletion over a flag, a function over a one-method
class, a platform feature over a library, a library over a framework.

## Skills

Run a skill when its trigger matches. Skills carry the *how*; this file carries the *what*.

| Skill | Use for |
|---|---|
| loop-engineering | structuring any loop by tier |
| ponytail | Delete Before Create and after-pass simplification |
| repo-analysis | learning from a reference repo without copying it |
| architecture-review | coupling, boundaries, responsibility leaks |
| dependency-review | keep / replace / remove each dependency |
| performance-review | hot paths and resource use vs the adapter budget |
| security-review | secrets, inputs, authz, data handling |
| testing | what to test, where, and what is not worth testing |
| documentation | keeping memory and docs current |
| debugging | reproduce → isolate → minimal fix → regression test |
| release | version bump, changelog, tag, notes |
| refactoring | behavior-preserving structural change |
| ux-review | navigation, feedback, state coverage |
| accessibility | semantics, keyboard, focus, contrast |
| design-system | token usage and component reuse |
| project-planner | backlog, roadmap, next loop |
| risk-analysis | technical / product / security risk |

## Agents

Delegate to a subagent when the work matches its description. Each agent runs the skills it owns
and writes its findings to the right memory or loop file.

| Agent | Delegate when |
|---|---|
| adf-planner | roadmap, prioritization, next-loop, risk triage |
| adf-architect | new module, structural change, or new dependency |
| adf-implementer | driving a change/feature loop (default driver) |
| adf-simplifier | immediately after any implement step |
| adf-tester | designing, writing, or running tests |
| adf-security | a change touches inputs, auth, secrets, or permissions |
| adf-performance | a perf-sensitive or hot-path change |
| adf-frontend-reviewer | any UI change |
| adf-debugger | a reported bug or failing behavior |
| adf-documenter | loop close, release notes, memory update |
| adf-researcher | a repo added to `references/`, or prior art is needed |

## Workflows

A workflow is a fixed agent composition with an exit gate. See `core/workflows/`:
`feature`, `bug`, `refactor`, `release`, `research`.

## When in doubt

Size the loop up, not down. Run the gate, don't guess it. Delete before you create. Write what
you learned to memory before you close the loop.
