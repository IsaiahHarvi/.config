#!/usr/bin/env bash
set -euo pipefail

DOTFILES_ROOT="${DOTFILES_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"

normalize_os() {
  local value="${1:-}"
  case "$value" in
    Darwin|darwin|mac|macos|Mac|MacOS) echo "macos" ;;
    Linux|linux|ubuntu|Ubuntu|debian|Debian) echo "linux" ;;
    *) echo "" ;;
  esac
}

selected_os="$(normalize_os "${DOTFILES_OS:-$(uname -s)}")"

if [ -z "$selected_os" ]; then
  echo "[dotfiles] Unsupported or missing OS. Set DOTFILES_OS=macos or DOTFILES_OS=linux." >&2
  exit 1
fi

target_script="$DOTFILES_ROOT/scripts/setup-${selected_os}.sh"

if [ ! -x "$target_script" ]; then
  echo "[dotfiles] Missing setup script for ${selected_os}: $target_script" >&2
  exit 1
fi

echo "[dotfiles] Using ${selected_os} setup"
exec "$target_script" "$@"
