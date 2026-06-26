---
name: design-system
description: Check token usage and component reuse; flag one-off styles. Use for any UI change. Tokens are defined in the adapter, not here. Output is consistency findings.
---

# design-system

## Purpose
Keep the UI coherent by using the shared tokens and components instead of one-offs.

## Trigger
Any UI change that introduces or alters styling or components.

## Procedure
1. **Token usage** — color, type, spacing, radius, motion come from the adapter's tokens, not
   hardcoded values.
2. **Component reuse** — an existing component covers this need before a new one is built.
3. **One-off styles** — flag bespoke values that duplicate or drift from a token.
4. **New component justification** — if a new component is needed, it composes existing tokens and
   earns its place (ponytail).
5. **Consistency** — same intent renders the same way across the surface.

## Output
Consistency findings: each hardcoded value or one-off mapped to the token/component it should use.
The token set itself is defined in `adf-adapter/`, never in core.

## Anti-patterns
- Hardcoding a value that a token already defines.
- A new component that duplicates an existing one.
- Defining tokens in core — they belong to the adapter.
