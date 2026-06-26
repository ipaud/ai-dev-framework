#!/usr/bin/env bash
# ADF PreToolUse hook (Edit|Write): one-line Delete Before Create reminder + active loop.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOOPS="$ROOT/adf-memory/loops"

active=""
if [ -d "$LOOPS" ]; then
  active="$(ls -t "$LOOPS"/*.md 2>/dev/null | grep -v '/0000-template.md' | head -n 1 || true)"
fi

echo "Delete Before Create: need it at all? already here? platform/dep covers it? one line?"
if [ -n "$active" ]; then
  echo "Active loop: ${active#"$ROOT"/}"
else
  echo "No active loop — record this work in adf-memory/loops/NNNN-slug.md."
fi
