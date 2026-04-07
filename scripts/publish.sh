#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE_DIR="$ROOT_DIR/jl4ctukblog"
PUBLIC_DIR="$SITE_DIR/public"
THEME_DIR="$SITE_DIR/themes/hugo-theme-re-terminal"

cd "$ROOT_DIR"
git submodule sync --recursive

if [[ ! -e "$THEME_DIR/.git" ]]; then
  git submodule update --init --recursive jl4ctukblog/themes/hugo-theme-re-terminal
fi

if [[ ! -e "$PUBLIC_DIR/.git" ]]; then
  git submodule update --init jl4ctukblog/public
fi

"$ROOT_DIR/scripts/hugo.sh" --source "$SITE_DIR" --destination "$PUBLIC_DIR"
