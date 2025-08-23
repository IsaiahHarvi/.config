#!/bin/bash

create_symlink() {
  local target="$1"
  local link_name="$2"

  if [ -e "$link_name" ]; then
    if [ -L "$link_name" ]; then
      echo "Skipping: $link_name already exists."
      return
    else
      echo "Backing up existing file: $link_name"
      mv "$link_name" "${link_name}.backup"
    fi
  fi

  ln -s "$target" "$link_name"
  echo "Created symlink: $link_name -> $target"
}

CONFIG_DIR="$HOME/.config"

# Files to symlink (target -> link)
FILES=(
  "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
  "$CONFIG_DIR/vim/.vimrc" "$HOME/.vimrc"
  "$CONFIG_DIR/vim/.vim/coc-settings.json" "$HOME/.vim/coc-settings.json"
  "$CONFIG_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  "$CONFIG_DIR/pmy" "$HOME/.pmy"
  "$CONFIG_DIR/treeignore" "$HOME/.treeignore"
)

for ((i=0; i<${#FILES[@]}; i+=2)); do
  create_symlink "${FILES[i]}" "${FILES[i+1]}"
done

# Install Vim Plug if missing
PLUG_PATH="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$PLUG_PATH" ]; then
  echo "Installing Vim Plug..."
  curl -fLo "$PLUG_PATH" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "Vim Plug already installed."
fi

# Install Starship prompt if missing
if ! command -v starship &>/dev/null; then
  echo "Installing Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
  echo "Starship already installed."
fi

if ! grep -Fxq 'eval "$(starship init zsh)"' "$HOME/.zshrc"; then
  echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

# Zinit
if ! command -v zinit &>/dev/null; then
  echo "Installing Zinit..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/main/scripts/install.sh)" -- --unattended -y
else
  echo "Zinit already installed."
fi

# PMY
if ! command -v pmy &>/dev/null; then
    if ! command -v go &>/dev/null; then
        echo "Error: Go not found in PATH. To install PMY, install Go first." >&2
    fi
    if [[ "$(uname -s)" == "Darwin" ]]; then
        sudo env GOBIN=/usr/local/bin go install github.com/relastle/pmy@latest
    else
	sudo go install github.com/relastle/pmy@latest
    fi
fi


is_ubuntu() {
  [ -r /etc/os-release ] && grep -q '^ID=ubuntu' /etc/os-release
}

is_graphical_session() {
  [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]
}

if is_ubuntu && is_graphical_session; then
  echo "Installing i3 desktop stack..."
  sudo apt update
  sudo apt install -y i3 i3status i3lock dmenu dunst network-manager-gnome picom \
      feh rofi xterm xclip wl-clipboard fzf ripgrep
else
    echo "Skipping i3 install..."
fi



echo "Reload zsh."

exit 0
