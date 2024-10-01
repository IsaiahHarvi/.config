#!/bin/bash

NVCHAD_PATH="$HOME/.config/nvim"
if [ ! -d "$NVCHAD_PATH" ]; then
  git clone https://github.com/NvChad/NvChad $NVCHAD_PATH --depth 1 && nvim
fi
