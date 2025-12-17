#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

install_linux_packages() {
  if ! is_ubuntu; then
    log "Non-Ubuntu Linux detected; skipping apt installs"
    return
  fi

  if ! have_cmd apt-get; then
    warn "apt-get not found; skipping package installs"
    return
  fi

  if ! run_as_root apt-get update; then
    warn "Unable to update apt cache; skipping package installs"
    return
  fi

  local cli_packages=(
    fzf
    ripgrep
    xclip
    wl-clipboard
  )

  run_as_root apt-get install -y "${cli_packages[@]}" || warn "Failed to install CLI packages"

  if is_graphical_session; then
    local gui_packages=(
      i3
      i3status
      i3lock
      dmenu
      dunst
      network-manager-gnome
      picom
      feh
      rofi
      xterm
    )

    run_as_root apt-get install -y "${gui_packages[@]}" || warn "Failed to install GUI packages"
  else
    log "No graphical session detected; skipping i3-related packages"
  fi
}

log "Running Linux setup"
link_core_configs
install_shared_tools
install_linux_packages
log "Linux setup complete"
