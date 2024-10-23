#!/bin/bash

declare -A CONFIG_FILES=(
    ["$HOME/.config/vim/.vim"]="$HOME/.vim"
    ["$HOME/.config/vim/.vimrc"]="$HOME/.vimrc"
)

for SOURCE_PATH in "${!CONFIG_FILES[@]}"; do
    DEST_PATH=${CONFIG_FILES[$SOURCE_PATH]}
    
    if [ -e "$SOURCE_PATH" ]; then
        mv "$SOURCE_PATH" "$DEST_PATH"
    else
        echo "Source $SOURCE_PATH does not exist."
    fi
done

