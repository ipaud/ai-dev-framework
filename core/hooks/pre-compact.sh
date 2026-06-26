#!/usr/bin/env bash
# ADF PreCompact hook: before context compaction, surface the durable state that must survive it.
# Compaction summarizes earlier turns away; this reminds the agent to ensure memory is written
# first and reprints the paths that reconstruct state in the compacted context.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LOOPS="$ROOT/adf-memory/loops"

active=""
if [ -d "$LOOPS" ]; then
  active="$(ls -t "$LOOPS"/*.md 2>/dev/null | grep -v '/0000-template.md' | head -n 1 || true)"
fi

echo "Before compaction — durable state must survive (compaction alone is insufficient):"
echo "  - Is the active loop's Plan/Validate current in its file?"
echo "  - Does project.md reflect works / in-flight / broken?"
echo "Re-anchor after compaction from:"
echo "  - adf-memory/project.md"
if [ -n "$active" ]; then
  echo "  - ${active#"$ROOT"/}"
else
  echo "  - (no active loop)"
fi
