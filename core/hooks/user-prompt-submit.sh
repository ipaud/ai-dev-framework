#!/usr/bin/env bash
# ADF UserPromptSubmit hook: inject the active loop each prompt. SessionStart prints the read
# order once, but it goes stale within a long session; this keeps the active loop in view.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOOPS="$ROOT/adf-memory/loops"

active=""
if [ -d "$LOOPS" ]; then
  active="$(ls -t "$LOOPS"/*.md 2>/dev/null | grep -v '/0000-template.md' | head -n 1 || true)"
fi

if [ -n "$active" ]; then
  echo "ADF active loop: ${active#"$ROOT"/} — keep the change inside its Goal; gates decide done."
else
  echo "ADF: no active loop — size one (trivial/change/feature) before non-trivial edits."
fi
