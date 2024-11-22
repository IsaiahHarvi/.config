#!/bin/bash


create_symlink() {
  local target="$1"
  local link_name="$2"

  if [ -e "$link_name" ]; then
    echo "Skipping: $link_name already exists."
  else
    ln -s "$target" "$link_name"
    echo "Created symlink: $link_name -> $target"
  fi
}

CONFIG_DIR="$HOME/.config"

# Files to symlink (list pairs: target -> link_name)
FILES_TO_SYMLINK=(
  "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
  "$CONFIG_DIR/vim/.vimrc" "$HOME/.vimrc"
  "$CONFIG_DIR/vim/.vim/coc-settings.json" "$HOME/.vim/coc-settings.json"
  "$CONFIG_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
)

# Iterate over the file pairs
for ((i=0; i<${#FILES_TO_SYMLINK[@]}; i+=2)); do
  target="${FILES_TO_SYMLINK[i]}"
  link_name="${FILES_TO_SYMLINK[i+1]}"
  create_symlink "$target" "$link_name"
done


# NVIM Setup
NVCHAD_PATH="$HOME/.config/nvim"
if [ ! -d "$NVCHAD_PATH" ]; then
  echo "Installing NvChad..."
  git clone https://github.com/NvChad/NvChad "$NVCHAD_PATH" --depth 1
  if [ $? -eq 0 ]; then
    echo "NvChad installed successfully."
  else
    echo "Failed to install NvChad."
    exit 1
  fi
else
  echo "NvChad is already installed."
fi

# VIM Setup
PLUG_PATH="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$PLUG_PATH" ]; then
  echo "Installing Vim Plug..."
  curl -fLo "$PLUG_PATH" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if [ $? -eq 0 ]; then
    echo "Vim Plug installed successfully."
  else
    echo "Failed to install Vim Plug."
    exit 1
  fi
else
  echo "Vim Plug is already installed."
fi

# ZSH Setup
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  if [ $? -eq 0 ]; then
    echo "Oh My Zsh installed successfully."
  else
    echo "Failed to install Oh My Zsh."
    exit 1
  fi
else
  echo "Oh My Zsh is already installed."
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "Powerlevel10k theme is already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing Zsh Autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "Zsh Autosuggestions is already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  echo "Installing Zsh Completions plugin..."
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
else
  echo "Zsh Completions plugin is already installed."
fi

echo "Setup completed successfully."

