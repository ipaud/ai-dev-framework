# ADR-0003: Consumption model

- **Status:** accepted
- **Date:** 2026-06-26

## Context
A project needs to adopt ADF's method and keep it upgradeable, without forking the framework or
leaking project state into it. Three shapes were possible: a git submodule, a published package,
or a copied template.

## Decision
Consume ADF as a **git submodule at `adf/`**, with **project-local state** generated in the
consumer by `adf-init.sh`:
- `adf-memory/` — project state (loops, decisions, lessons, score).
- `adf-adapter/` — stack, gates, budgets, security, tokens.

Core stays agnostic and read-only to the consumer; all stack-specific and stateful content lives
outside the submodule.

## Alternatives considered
- **Published package** — version-pinned and clean, but awkward for files meant to be read and
  symlinked (skills, agents, hooks), and harder to patch in place during a project.
- **Copied template** — diverges immediately; no upgrade path; the agnostic boundary erodes as
  the copy is edited.

## Consequences
- A project upgrades ADF with a submodule bump, never touching its own state.
- The core can stay agnostic because state has nowhere to live inside it.
- Consumers must run `adf-init.sh` once to generate state and wiring, and again after a core
  update in copy-mode.
