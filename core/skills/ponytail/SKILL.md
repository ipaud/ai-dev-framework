---
name: ponytail
description: Delete Before Create and the simplify after-pass. Use before adding any file or dependency, and immediately after any implement step, to force the smallest correct change. Output is the line delta and dependency delta.
allowed-tools: Read Grep Glob Edit Write
---

# ponytail

## Purpose
Keep the change the smallest one that works. The best code is the code never written.

## Trigger
- Before creating any new file, abstraction, or dependency.
- Immediately after any implement step (the after-pass).

## Procedure
1. **Delete Before Create** — answer all four, log them in the loop file:
   1. Does this need to exist at all? (speculative ⇒ skip, say so)
   2. Does something already in the codebase do it?
   3. Does the platform or an already-installed dependency cover it?
   4. Can it be one line / one function instead of a new abstraction?
   Stop at the first answer that holds.
2. **Prefer**, every time: deletion over a flag; a function over a one-method class; a platform
   feature over a library; a library over a framework.
3. **After-pass** (post-implement): re-read the diff. Remove dead branches, collapse needless
   indirection, inline single-use helpers, drop unused parameters and dependencies.
4. **Mark deliberate shortcuts** with a `ponytail:` comment naming the ceiling and the upgrade
   path, so a simplification reads as intent, not ignorance.

## Output
Two lines in the loop file:
- **Lines:** `-N / +M` (deleted vs added).
- **Dependencies:** added `[…]`, removed `[…]`, net change.

## Anti-patterns
- An interface with one implementation; a factory for one product; config for a value that never changes.
- Scaffolding "for later." Later can scaffold for itself.
- Clever over boring — clever is what someone decodes at 3am.
- Simplifying away input validation, error handling that prevents data loss, security, or accessibility.
