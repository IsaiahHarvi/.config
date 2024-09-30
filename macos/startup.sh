#! /bin/bash

defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder
defaults write -g ApplePressAndHoldEnabled -bool false


if ! command -v zsh >/dev/null 2>&1; then
  echo "Zsh is not installed."
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Powerlevel10k is not installed. Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
fi

