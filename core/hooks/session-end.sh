#!/usr/bin/env bash
# ADF SessionEnd hook: flush durable state before the session terminates, so the next session
# can reconstruct work from adf-memory rather than a lost context window.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOOPS="$ROOT/adf-memory/loops"

active=""
if [ -d "$LOOPS" ]; then
  active="$(ls -t "$LOOPS"/*.md 2>/dev/null | grep -v '/0000-template.md' | head -n 1 || true)"
fi

echo "Session ending — confirm durable state is written:"
echo "  [ ] active loop file updated (Plan / Validate / Ponytail deltas / Reflect)?"
echo "  [ ] project.md current?"
echo "  [ ] new lessons/decisions/risks recorded?"
if [ -n "$active" ]; then
  echo "Resume next session from: ${active#"$ROOT"/} (and prompts/continue.md)."
else
  echo "Resume next session from: adf-memory/roadmap.md (pick the next loop)."
fi
