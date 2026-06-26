# AGENTS.md

> Portable entry point for any AI coding agent (the [AGENTS.md](https://agents.md) convention).
> ADF's method is tool-neutral; this file and `core/CLAUDE.md` are two names for the same
> constitution so Claude Code and non-Claude tools both find it.

This repository is **ADF** — a stack-agnostic agent development environment, consumed by other
projects as a git submodule at `adf/`. See `README.md` for what it is and `docs/architecture.md`
for how it is built.

## If you are working ON ADF (this repo)

Read `CLAUDE.md` — the agnostic constitution (invariants, read order, loop tiers). It governs
how changes to ADF itself are made: Delete Before Create, objective gates decide done, one loop one
commit. Then `docs/roadmap.md` for what's next.

## If you are working IN a project that consumes ADF

Read in order:
1. `adf/CLAUDE.md` (= `adf/AGENTS.md`) — the method and invariants.
2. `adf-adapter/ADAPTER.md` — the project's stack, gate commands, budgets, security, tokens.
3. `adf-memory/` — project state: `project.md` first, then the active loop in `adf-memory/loops/`.

Never edit anything under `adf/` — it is a read-only submodule. Change behavior through the adapter
and memory.
