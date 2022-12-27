#!/bin/sh

# The famous "get a menu of emojis to copy" script of Luke Smith modded for bemenu and wayland.


# Get user selection via bemenu from emoji file.
chosen=$(cut -d ';' -f1 ~/.config/sway/scripts/emoji/emojis | bemenu -p "pick" -i -l 30 | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

printf "%s" "$chosen" | wl-copy
notify-send "'$chosen' copied to clipboard." &
