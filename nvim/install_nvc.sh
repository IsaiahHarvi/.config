#!/bin/bash

NVCHAD_PATH="$HOME/.config/nvim"
if [ ! -d "$NVCHAD_PATH" ]; then
  print_message "NvChad is not installed. Installing NvChad..."
  git clone https://github.com/NvChad/NvChad $NVCHAD_PATH --depth 1
fi
