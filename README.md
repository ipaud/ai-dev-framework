# ADF — AI Development Framework

ADF is the *environment* an AI coding agent works in. It is **stack-agnostic**: it carries the
working method (loops, gates, memory, skills, agents) and nothing about any specific technology.
A project consumes ADF as a git submodule at `adf/` and supplies its own stack details in a
project-local adapter.

## What ADF gives a project

- **A constitution** (`CLAUDE.md`, also reachable as `AGENTS.md`) — invariants and the read order
  the agent follows.
- **17 skills** (`core/skills/`) — reusable procedures the agent runs (loops, reviews, testing,
  release, planning, …).
- **11 agents** (`core/agents/`) — Claude Code subagents the orchestrator delegates to.
- **Workflows** (`core/workflows/`) — fixed agent compositions with an exit gate.
- **Templates + memory** (`core/templates/`, `core/memory/`) — fill-in skeletons and the
  project-local memory layout.
- **Hooks + wiring scripts** (`core/hooks/`, `scripts/`) — make the above load in Claude Code.

## The three layers

| Layer | Lives in | Agnostic? | Who writes it |
|---|---|---|---|
| **Core** | `adf/` (this submodule) | Yes — zero stack names | ADF |
| **Adapter** | consumer `adf-adapter/` | No — stack, gates, budgets, security | the project |
| **Memory** | consumer `adf-memory/` | No — project state, loops, decisions | the agent, per loop |

Core never names a stack. Gate commands, performance budgets, and security specifics live only
in the adapter. State lives only in the consumer.

## Consumption

From a consuming project's root:

```sh
git submodule add <adf-repo-url> adf
adf/scripts/adf-init.sh      # generates adf-memory/ + adf-adapter/, wires .claude/
adf/scripts/adf-doctor.sh    # verifies the install
```

`adf-init.sh` symlinks the skills and agents into `.claude/` so Claude Code discovers them
(falling back to copies on filesystems without symlink support), registers the hooks in
`.claude/settings.json`, and seeds the memory and adapter from templates. `adf-doctor.sh`
checks the install and prints a pass/fail line per check.

After init, fill in `adf-adapter/ADAPTER.md` with the project's stack, gate commands, and
budgets. See `examples/gesturelab/ADAPTER.md` for a worked example.

### As a plugin (alternative)

ADF also ships a Claude Code plugin manifest (`.claude-plugin/`) for native install/update of the
skills, agents, and hooks:

```sh
claude plugin marketplace add ipaud/ai-dev-framework
claude plugin install adf@adf
```

The plugin path covers skills/agents/hooks discovery; the **submodule path remains the supported
way to get project-local `adf-memory/` + `adf-adapter/` state** (the plugin does not seed those).
Use the submodule for a full ADF project; the plugin to share just the skills/agents/hooks. See
ADR-0007.

## Principles

- **Objective gates decide done.** The adapter's per-tier gate commands are the source of truth.
- **AI Score is advisory.** A trend signal recorded per loop — never a gate.
- **Delete Before Create.** Prefer the smallest correct change; reach for stdlib and native
  features before new code.
- **One loop, one focused commit.** Loops scale to the task (trivial / change / feature).

## Versioning

Pre-1.0. First real consumer installed: **CLUBZ** (`clubzapp`) — submodule + `adf-init.sh`,
`adf-adapter/ADAPTER.md` filled with its real stack, gate commands verified green
(`typecheck`/`lint`/`test:run`). One consumer validated; a second, different one is the remaining
path to 1.0 (see `docs/roadmap.md`). The API of skills, agents, and scripts may still change until
then. See `CHANGELOG.md`.

## License

MIT — see `LICENSE`.
