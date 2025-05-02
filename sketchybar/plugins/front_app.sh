#!/usr/bin/env zsh

ICON_PADDING_RIGHT=5

case $INFO in
"Finder")
    ICON=󰀶
    ;;
"Firefox")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"Spotify")
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
"Code")
    ICON_PADDING_RIGHT=4
    ICON=󰨞
    ;;
*)
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set $NAME.name label="$INFO"
