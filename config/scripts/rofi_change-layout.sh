#!/usr/bin/env bash

LAYOUT_DIR="$HOME/.screenlayout/"

menu_cmd() {
  rofi -dmenu -i
}

layouts=$(ls "$LAYOUT_DIR")
chosen_layout="$(echo -e "$layouts" | menu_cmd)"
source "$LAYOUT_DIR/$chosen_layout"

