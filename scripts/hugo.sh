#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="$ROOT_DIR/.tools/hugo"
REQUIRED_VERSION="0.128.0"
HUGO_BIN=""

version_ge() {
  local current="$1"
  local required="$2"
  [[ "$(printf '%s\n%s\n' "$current" "$required" | sort -V | head -n1)" == "$required" ]]
}

detect_system_hugo() {
  if ! command -v hugo >/dev/null 2>&1; then
    return 1
  fi

  local version
  version="$(hugo version | sed -n 's/.* v\([0-9.]*\).*/\1/p' | head -n1)"

  if [[ -n "$version" ]] && version_ge "$version" "$REQUIRED_VERSION"; then
    HUGO_BIN="$(command -v hugo)"
    return 0
  fi

  return 1
}

download_hugo() {
  local target_dir="$TOOLS_DIR/$REQUIRED_VERSION"
  local archive="$target_dir/hugo_extended.tar.gz"
  local url="https://github.com/gohugoio/hugo/releases/download/v${REQUIRED_VERSION}/hugo_extended_${REQUIRED_VERSION}_linux-amd64.tar.gz"

  mkdir -p "$target_dir"

  if [[ ! -x "$target_dir/hugo" ]]; then
    curl -fL -o "$archive" "$url"
    tar -xzf "$archive" -C "$target_dir"
  fi

  HUGO_BIN="$target_dir/hugo"
}

if ! detect_system_hugo; then
  download_hugo
fi

exec "$HUGO_BIN" "$@"
