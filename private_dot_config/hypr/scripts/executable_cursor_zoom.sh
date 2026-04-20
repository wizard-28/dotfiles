#!/usr/bin/env bash

notify-send "Activated"
dir="$1" # in or out

steps=8     # number of increments (tune this)
delay=0.01  # seconds between steps (tune this)
factor=1.05 # small scale per step (tune this)

for i in $(seq 1 $steps); do
  current=$(hyprctl -j getoption cursor:zoom_factor | jq -r '.float')

  if [ "$dir" = "in" ]; then
    new=$(awk "BEGIN {print $current * $factor}")
  else
    new=$(awk "BEGIN {print $current / $factor}")
    # clamp to 1
    new=$(awk "BEGIN {print ($new < 1 ? 1 : $new)}")
  fi

  hyprctl keyword cursor:zoom_factor "$new"
  sleep $delay
done
