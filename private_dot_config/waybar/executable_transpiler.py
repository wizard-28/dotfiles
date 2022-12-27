#!/bin/env python3

from tomli import load
from json import dump
from pathlib import Path

if __name__ == "__main__":
    with open(Path("~/.config/waybar/config.toml").expanduser(), "rb") as toml:
        with open(Path("~/.config/waybar/config").expanduser(), "w") as json:
            dump(load(toml), json, indent=4)
