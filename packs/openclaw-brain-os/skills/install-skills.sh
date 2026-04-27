#!/usr/bin/env bash
set -euo pipefail

PACK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${SKILLS_ROOT:-$HOME/.agents/skills}"
MODE="${SKILL_INSTALL_MODE:-missing-only}"
mkdir -p "$TARGET"

for src in "$PACK_DIR"/skills/bundled/*; do
  [[ -d "$src" ]] || continue
  name="$(basename "$src")"
  dest="$TARGET/$name"
  if [[ -e "$dest" && "$MODE" != "overwrite" ]]; then
    echo "skip existing skill: $name"
    continue
  fi
  if [[ -e "$dest" && "$MODE" == "overwrite" ]]; then
    rm -rf "$dest"
  fi
  cp -R "$src" "$dest"
  echo "installed skill: $name"
done
