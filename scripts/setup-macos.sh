#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

apply_macos_defaults() {
  local defaults_script="$DOTFILES_ROOT/macos/startup.sh"
  if [ "${APPLY_MACOS_DEFAULTS:-0}" != "1" ]; then
    log "Skipping macOS defaults (set APPLY_MACOS_DEFAULTS=1 to run $defaults_script)"
    return
  fi

  if [ ! -x "$defaults_script" ]; then
    warn "macOS defaults script not found at $defaults_script"
    return
  fi

  log "Applying macOS defaults..."
  "$defaults_script"
}

log "Running macOS setup"
link_core_configs
install_shared_tools
apply_macos_defaults
log "macOS setup complete"
