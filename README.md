# Dotfiles

Opinionated configs for terminals, editors, and window managers across macOS and Linux.

## Quickstart

```bash
git clone git@github.com:IsaiahHarvi/.config.git ~/.config
cd ~/.config
./setup.sh            # auto-detects macOS or Linux
# DOTFILES_OS=linux ./setup.sh   # force a specific OS, useful in containers
```

## What the setup does

- Symlinks configs from the repo into `~/.config` and key dotfiles like `~/.zshrc`, `~/.vimrc`, and `~/.tmux.conf`.
- Installs shared tooling: Vim Plug, Starship, Zinit, and pmy (if Go is available).
- On Ubuntu, installs common CLI packages plus i3-related packages when a graphical session is detected.

## Script layout

- `setup.sh` – entrypoint that dispatches to the right OS script.
- `scripts/setup-macos.sh` and `scripts/setup-linux.sh` – per-OS steps.
- `scripts/common.sh` – helpers for linking and shared installs.
- `macos/startup.sh` – optional macOS defaults; gated behind `APPLY_MACOS_DEFAULTS=1`.
