# ADF architecture

This describes how ADF itself is built — the pieces, how they separate, and how they reach the
agent at runtime. For the working method the agent follows, see `core/CLAUDE.md`.

## Three layers, three locations

```
consumer-project/
  adf/              ← ADF submodule (core). Agnostic. Read-only to the consumer.
  adf-adapter/      ← project's stack, gates, budgets, security, tokens. Project-local.
  adf-memory/       ← project state: loops, decisions, lessons, score. Project-local.
  .claude/          ← skills + agents (wired from adf/core), settings.json (hooks)
  CLAUDE.md         ← thin: points at adf/CLAUDE.md → adf-adapter → adf-memory
```

- **Core is agnostic.** Nothing under `core/` names a stack, a gate command, a budget number,
  or a security specific. Those are knobs the adapter turns.
- **Adapter is the only stack-aware layer.** Gate commands per tier, performance budgets,
  security specifics, and design tokens live here. ADF ships an adapter *template* and a worked
  example; the real adapter is generated in the consumer.
- **Memory is project-local and never in the submodule.** `adf-init.sh` creates it in the
  consumer from `core/memory/` templates.

This separation is what lets one ADF serve many projects and lets a project upgrade ADF (a
submodule bump) without touching its own state.

## What lives in the submodule

| Path | Contents | Role |
|---|---|---|
| `CLAUDE.md` (= `AGENTS.md`) | the constitution | invariants + read order; at the submodule root so `adf/CLAUDE.md` resolves, and portable to non-Claude tools via `adf/AGENTS.md` |
| `core/skills/` | 17 `SKILL.md` folders | procedures the agent runs |
| `core/agents/` | 11 subagent files | delegation targets |
| `core/workflows/` | 5 compositions | agent order + exit gate |
| `core/templates/` | 11 skeletons | fill-in artifacts |
| `core/memory/` | 8 files + loop template | seed for `adf-memory/` |
| `core/hooks/` | 3 shell hooks | runtime nudges |

## Wiring — how skills and agents reach Claude Code

Claude Code discovers skills under `.claude/skills/<name>/SKILL.md` and agents under
`.claude/agents/<name>.md`. ADF keeps the source of truth in `core/` and exposes it by
**symlinking** each skill folder and agent file into `.claude/` during `adf-init.sh`. One
source, two views: edit in `core/`, discovered under `.claude/`.

On filesystems without symlink support (e.g. exFAT) init **falls back to copying**. Copies are
not live — after a core submodule update the consumer must re-run `adf-init.sh`. `adf-doctor.sh`
verifies "wired (symlink or copy)" rather than assuming symlinks. See ADR-0002.

Hooks are registered in `.claude/settings.json` (SessionStart, PreToolUse on Edit|Write, Stop).
If the consumer already has a `settings.json`, init prints the block to merge rather than
overwriting.

## The loop model

Work happens in **loops** sized to the task: trivial / change / feature (when unsure, size up).
One loop produces one focused commit. A feature-tier loop runs the 9-step depth in
`core/skills/loop-engineering/`, records itself in `adf-memory/loops/NNNN-slug.md`, and closes
only when the adapter's objective gates are green. The AI Score is recorded as an advisory trend
and never decides done (ADR-0004).

## Why agnostic core + adapter (not a template or a package)

ADF is consumed as a submodule with project-local state, not copied or installed as a package.
A submodule keeps the core upgradeable and unforked; project-local state keeps the core
agnostic. See ADR-0003.
