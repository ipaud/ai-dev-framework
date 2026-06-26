#!/usr/bin/env bash
# ADF SessionStart hook: print the read order and the active loop. No file dumps.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOOPS="$ROOT/adf-memory/loops"

# Active loop = newest non-template loop file (mtime-based; see docs/known-issues.md).
active=""
if [ -d "$LOOPS" ]; then
  active="$(ls -t "$LOOPS"/*.md 2>/dev/null | grep -v '/0000-template.md' | head -n 1 || true)"
fi

echo "ADF read order:"
echo "  1. adf/CLAUDE.md          (method + invariants)"
echo "  2. adf-adapter/ADAPTER.md (stack, gates, budgets, security, tokens)"
echo "  3. adf-memory/            (project.md, then the active loop)"
if [ -n "$active" ]; then
  echo "Active loop: ${active#"$ROOT"/}"
else
  echo "Active loop: none (start one from core/memory/loops/0000-template.md)"
fi
