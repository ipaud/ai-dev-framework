---
name: accessibility
description: WCAG-aligned review of semantics, keyboard navigation, focus order, contrast, ARIA, and reduced-motion. Use for any UI change. Output is violations by WCAG level.
allowed-tools: Read Grep Glob
---

# accessibility

## Purpose
Make the UI usable by everyone — keyboard, screen reader, low vision, motion-sensitive.

## Trigger
Any UI change.

## Procedure
1. **Semantics** — correct elements for their role; structure conveys meaning without sight.
2. **Keyboard navigation** — every interactive element reachable and operable by keyboard alone.
3. **Focus order** — focus moves in a logical order; visible focus indicator; no traps.
4. **Contrast** — text and meaningful graphics meet WCAG contrast ratios.
5. **ARIA** — used only to fill gaps native semantics can't; correct roles/states; no overrides
   of working native semantics.
6. **Reduced motion** — honor the user's reduced-motion preference; no essential info conveyed by
   motion alone.

## Output
Violations grouped by **WCAG level (A / AA / AAA)**, each with location, the criterion, and the
fix. A/AA issues block a UI loop.

## Anti-patterns
- ARIA bolted onto non-semantic markup instead of using the right element.
- Mouse-only interactions.
- Conveying state by color or motion alone.
