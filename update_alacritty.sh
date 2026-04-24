#!/bin/bash

declare -A themes_array
themes_array=(
  ["badwolf"]="badwolf"
  ["default"]="gotham"
  ["dracula"]="dracula_plus"
  ["grayscale"]="miasma"
  ["gruvbox"]="gruvbox_material_medium_dark"
  ["nord"]="nord"
)

alacritty_theme=${themes_array[$THEME]}
sed "s/{theme}/$alacritty_theme/g" ~/.config/alacritty/alacritty.toml.base >~/.config/alacritty/alacritty.toml
