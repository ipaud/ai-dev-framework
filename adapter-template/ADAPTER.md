# Adapter: <project name>

> The only stack-aware layer. Everything ADF core leaves abstract is made concrete here. Fill in
> every section. See `examples/gesturelab/ADAPTER.md` for a worked example.

## Stack
<!-- Languages, frameworks, runtimes, key libraries. -->

## Gate commands (per tier)

The objective gates. A loop closes only when its tier's gates are green, with real output pasted
into the loop's Validate.

| Gate | Command | trivial | change | feature |
|---|---|:---:|:---:|:---:|
| build | `<cmd>` |  | ✓ | ✓ |
| typecheck | `<cmd>` |  | ✓ | ✓ |
| lint | `<cmd>` | ✓ | ✓ | ✓ |
| test | `<cmd>` |  | ✓ | ✓ |
| test (affected) | `<cmd>` | ✓ |  |  |
| performance | `<cmd>` |  |  | ✓ |
| security | `<cmd>` |  |  | ✓ |

## Performance budget
<!-- Concrete thresholds the performance-review skill checks against. Numbers, not adjectives. -->

## Security specifics
<!-- Permission model, CSP, secret handling, data-handling rules for security-review. -->

## Design tokens
<!-- Color, type, spacing, radius, motion tokens for the design-system skill. -->

## Conventions
<!-- Project rules the agent must follow (module boundaries, naming, ownership of state). -->

## Project skills
<!-- Project-specific skills in adf-adapter/skills/. Promote to core only after ≥2 projects. -->

## Project agents
<!-- Project-specific agents in adf-adapter/agents/. -->
