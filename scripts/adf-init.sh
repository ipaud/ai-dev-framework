#!/usr/bin/env bash
# adf-init.sh — wire ADF into a consuming project.
# Run after: git submodule add <url> adf
# Derives the ADF root and the consumer root from this script's location, so it works
# regardless of the current directory. All paths are quoted (the repo path may contain spaces).
set -euo pipefail

ADF="$(cd "$(dirname "$0")/.." && pwd)"   # the adf/ submodule root
ROOT="$(dirname "$ADF")"                  # the consumer project root
CLAUDE_DIR="$ROOT/.claude"

echo "[init] ADF:      $ADF"
echo "[init] consumer: $ROOT"

# 1. Project-local state directories.
mkdir -p "$ROOT/adf-memory/loops" "$ROOT/adf-adapter/skills" "$ROOT/adf-adapter/agents" \
         "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents"

# 2. Seed memory + adapter from templates (cp -n: never clobber existing state).
cp -n "$ADF"/core/memory/*.md "$ROOT/adf-memory/" 2>/dev/null || true
cp -n "$ADF/core/memory/loops/0000-template.md" "$ROOT/adf-memory/loops/" 2>/dev/null || true
cp -n "$ADF/adapter-template/ADAPTER.md" "$ROOT/adf-adapter/ADAPTER.md" 2>/dev/null || true
echo "[init] seeded adf-memory/ and adf-adapter/"

# Detect symlink capability (exFAT and friends can't): fall back to copying.
WIRE="symlink"
if ln -s "$ADF/VERSION" "$CLAUDE_DIR/.__symtest" 2>/dev/null && [ -L "$CLAUDE_DIR/.__symtest" ]; then
  rm -f "$CLAUDE_DIR/.__symtest"
else
  WIRE="copy"
  rm -f "$CLAUDE_DIR/.__symtest" 2>/dev/null || true
  echo "[init] WARNING: filesystem has no symlink support — using copies."
  echo "[init] copy-mode goes stale after a core update; re-run adf-init.sh then."
fi
echo "[init] wiring mode: $WIRE"

wire() { # $1 = source path, $2 = destination path
  rm -rf "$2"
  if [ "$WIRE" = "symlink" ]; then ln -s "$1" "$2"; else cp -r "$1" "$2"; fi
}

# 3. Wire skills into .claude/skills/<name>.
for dir in "$ADF"/core/skills/*/; do
  name="$(basename "$dir")"
  wire "$ADF/core/skills/$name" "$CLAUDE_DIR/skills/$name"
done

# 4. Wire agents into .claude/agents/<name>.md.
for file in "$ADF"/core/agents/*.md; do
  name="$(basename "$file")"
  wire "$ADF/core/agents/$name" "$CLAUDE_DIR/agents/$name"
done
echo "[init] wired skills and agents into .claude/"

# 5. Hook config. Never overwrite an existing settings.json — print the block to merge.
read -r -d '' SETTINGS <<EOF || true
{
  "hooks": {
    "SessionStart": [{ "hooks": [{ "type": "command", "command": "bash \"$ADF/core/hooks/session-start.sh\"" }] }],
    "PreToolUse": [{ "matcher": "Edit|Write", "hooks": [{ "type": "command", "command": "bash \"$ADF/core/hooks/pre-edit.sh\"" }] }],
    "Stop": [{ "hooks": [{ "type": "command", "command": "bash \"$ADF/core/hooks/post-loop.sh\"" }] }]
  }
}
EOF

if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "[init] .claude/settings.json exists — NOT overwriting. Merge this block:"
  printf '%s\n' "$SETTINGS"
else
  printf '%s\n' "$SETTINGS" > "$CLAUDE_DIR/settings.json"
  echo "[init] wrote .claude/settings.json"
fi

# 6. Thin entry points if absent: CLAUDE.md (Claude Code) and AGENTS.md (portable, agents.md
#    convention). Identical pointer content so non-Claude tools find the same method.
read -r -d '' ENTRYPOINT <<'EOF' || true
# Project constitution

This project runs on ADF. Read, in order:

1. `adf/CLAUDE.md` — the agnostic method and invariants.
2. `adf-adapter/ADAPTER.md` — this project's stack, gate commands, budgets, security, tokens.
3. `adf-memory/` — project state: `project.md` first, then the active loop in `adf-memory/loops/`.

Never edit anything under `adf/` (it is a read-only submodule). Change behavior through the
adapter and memory.

Reference repositories for the repo-analysis skill go under `references/` (git-ignored).
EOF

for entry in CLAUDE.md AGENTS.md; do
  if [ ! -f "$ROOT/$entry" ]; then
    printf '%s\n' "$ENTRYPOINT" > "$ROOT/$entry"
    echo "[init] wrote thin $entry"
  else
    echo "[init] $entry exists — left as-is."
  fi
done

echo "[init] done. Next: fill in adf-adapter/ADAPTER.md, then run adf/scripts/adf-doctor.sh"
