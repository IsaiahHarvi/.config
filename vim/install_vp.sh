#!/bin/bash

PLUG_PATH="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$PLUG_PATH" ]; then
  curl -fLo "$PLUG_PATH" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  if [ $? -eq 0 ]; then
    echo "Install Complete."
  else
    echo "Install Failed.."
    exit 1
  fi
fi


