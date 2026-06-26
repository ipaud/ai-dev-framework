# ADR-0001: License

- **Status:** accepted
- **Date:** 2026-06-26

## Context
ADF is a framework intended to be consumed by other projects as a submodule. It needs a license
that permits free use, modification, and embedding in both open and closed projects, with minimal
obligation on consumers.

## Decision
License ADF under the **MIT License**. The `LICENSE` file carries the standard MIT text.

## Alternatives considered
- **Apache-2.0** — adds an explicit patent grant and NOTICE handling; more ceremony than this
  project needs.
- **No license / all-rights-reserved** — would block the intended use (embedding as a submodule).
- **Copyleft (GPL family)** — would impose obligations on consuming projects, defeating the goal
  of a drop-in development environment.

## Consequences
- Consumers may use, modify, and embed ADF with attribution and no copyleft obligation.
- The license is permissive and well understood; no per-consumer legal review needed.
- This decision was the framework's single open question; it is now resolved.
