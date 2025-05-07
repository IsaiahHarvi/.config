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

# Ensure Starship init in .zshrc
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

# Determine ZINIT_HOME (prefer ~/.zinit, fallback to XDG)
ZINIT_HOME="$HOME/.zinit"
if [ ! -d "$ZINIT_HOME" ]; then
  XDG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/zinit"
  if [ -d "$XDG_PATH" ]; then
    ZINIT_HOME="$XDG_PATH"
  else
    echo "Error: cannot locate zinit directory" >&2
    exit 1
  fi
fi

# Remove any existing zinit entries from .zshrc
if [[ "$(uname)" == "Darwin" ]]; then
  sed -i '' '/zinit/d' "$HOME/.zshrc"
else
  sed -i '/zinit/d' "$HOME/.zshrc"
fi

# Append proper zinit setup to .zshrc (variables expanded at install time)
cat << EOF >> "$HOME/.zshrc"

# Zinit Plugin Manager Setup
export ZINIT_HOME="$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

# Load plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
EOF


echo -e "\nDon't forget to install Aerospace and PMY.\n"

echo "Setup complete. Please restart your shell to apply changes."
