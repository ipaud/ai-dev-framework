# ADR-0005: Agent roster

- **Status:** accepted
- **Date:** 2026-06-26

## Context
ADF delegates work to Claude Code subagents. The roster should cover the loop end to end —
planning, building, reviewing, supporting — without overlap, and each agent should have tools
restricted to its job.

## Decision
Ship **11 agents**, mapped to the phases of a loop:

| Agent | Delegate when | Tools |
|---|---|---|
| adf-planner | roadmap, prioritization, next-loop, risk triage | Read, Grep, Glob, Edit |
| adf-architect | new module, structural change, new dependency | Read, Grep, Glob, Edit |
| adf-implementer | driving a change/feature loop (default driver) | Read, Edit, Write, Bash |
| adf-simplifier | immediately after any implement step | Read, Edit, Write, Bash |
| adf-tester | designing/writing/running tests | Read, Edit, Write, Bash |
| adf-security | change touches inputs, auth, secrets, permissions | Read, Grep, Bash |
| adf-performance | perf-sensitive or hot-path change | Read, Grep, Bash |
| adf-frontend-reviewer | any UI change | Read, Grep, Glob |
| adf-debugger | a reported bug or failing behavior | Read, Edit, Write, Bash |
| adf-documenter | loop close, release notes, memory update | Read, Edit, Write |
| adf-researcher | a repo in `references/`, or prior art needed | Read, Grep, Glob, WebFetch |

Tool restriction is **by tool name**, since Claude Code's `tools` field is allow/deny per tool,
not per path. **Path scoping** ("write only under `adf-memory/…`") lives in each agent's system
prompt, because it cannot be expressed in the `tools` field.

## Alternatives considered
- **One generalist agent** — no tool restriction, no clear delegation signal, weaker reviews.
- **Path-scoped `tools`** (e.g. `edit(memory only)`) — not expressible in Claude Code; would
  produce invalid or ignored frontmatter.

## Consequences
- The orchestrator gets specific `description`s to delegate against.
- Review agents (security, performance, frontend) are read-only on code by tool set; they report,
  they don't patch.
- Path discipline is enforced by prompt, not frontmatter — restated in every agent's system prompt.
