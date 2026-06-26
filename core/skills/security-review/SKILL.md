---
name: security-review
description: Review secrets, permissions, input validation, dependency CVEs, authorization, data handling, transport, and storage. Use when a change touches inputs, auth, secrets, or permissions. Output is findings by severity.
---

# security-review

## Purpose
Find the ways the change can be abused or leak, before it ships.

## Trigger
A change touches user input, authentication, authorization, secrets, permissions, or sensitive
data.

## Procedure
1. **Secrets** — none hardcoded; loaded from env/secret manager; required ones validated at startup.
2. **Permissions** — least privilege; capabilities requested only when needed.
3. **Input validation** — all external input validated at the boundary; fail fast and explicit.
4. **Dependency CVEs** — run the adapter's audit command; triage by severity and exploitability.
5. **Authorization** — every state-changing path checks who is allowed; no bypass.
6. **Data handling** — minimal collection; sensitive data not logged; clear retention.
7. **Transport** — encrypted in transit; no sensitive data in URLs or query logs.
8. **Storage** — encrypted/scoped at rest as the adapter requires.

## Output
Findings grouped by severity (**critical / high / medium / low**). Critical blocks the loop.
Project specifics (CSP, audit command, permission model) come from the adapter.

## Anti-patterns
- Treating the audit command's clean exit as proof of security — it covers known CVEs only.
- Validating in the UI but not at the server/trust boundary.
- Leaking sensitive detail in error messages.
