# Workflow: feature

For new behavior or anything crossing a boundary. Feature-tier loop.

## Agents in order
1. **adf-planner** _(optional)_ — confirm this is the right next loop; set goal and not-doing.
2. **adf-architect** _(if it crosses a boundary)_ — decide structure and dependencies; write the
   ADR **first**, before any code.
3. **adf-implementer** — drive the loop; Delete Before Create, then the smallest correct change.
4. **adf-simplifier** — the ponytail after-pass; record line and dependency deltas.
5. **adf-tester** — test plan and tests; run the test gate.
6. **Applicable reviewers** — whichever the change triggers:
   - **adf-security** if it touches inputs, auth, secrets, or permissions.
   - **adf-performance** if it's perf-sensitive or on a hot path.
   - **adf-frontend-reviewer** if it changes UI.
7. **adf-documenter** — sync memory and docs for what changed.
8. **adf-planner** — propose the next loop.

## Exit gate
All feature-tier gate commands (from the adapter) green, with real output pasted in the loop's
Validate, **and** memory updated (loop log, decisions/lessons/known-issues as applicable). The AI
Score is advisory only.
