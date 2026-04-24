#!/bin/bash

SCRIPT_DIR=$(dirname "${0}")

function patchBashrc() {
  sed -i -e 's/^export THEME=.*/export THEME='"$THEME"'/g' ~/.bashrc
}

function patchXresources() {
  # Xresources theme
  if [ -z "$THEME" ]; then
    xrdb -DTHEME_XRESOURCES="<$HOME/.config/xresources/default>" -merge ~/.Xresources
  else
    xrdb -DTHEME_XRESOURCES="<$HOME/.config/xresources/$THEME>" -merge ~/.Xresources
  fi
}

function patchKittyConfig() {
  envsubst <~/.config/kitty/kitty.baseconf >~/.config/kitty/kitty.conf
}

function patchTermiteConfig() {
  envsubst <~/.config/termite/base >~/.config/termite/config
  envsubst <~/.config/termite/"${THEME}" >>~/.config/termite/config
}

function reloadi3Config() {
  cat ~/.config/i3/themes/"${THEME}"/config ~/.config/i3/config.base >~/.config/i3/config
  i3-msg reload
}

function restartPolybar() {
  ~/.config/polybar/launch.sh
}

function changeTheme() {
  theme="$1"
  export THEME="$theme"

  patchBashrc
  case "${TERMINAL}" in
  "kitty") patchKittyConfig ;;
  "termite") patchKittyConfig ;;
  "alacritty") "${SCRIPT_DIR}/update_alacritty.sh" ;;
  *) echo "Terminal emulator ${TERMINAl} not supported" ;;
  esac
  reloadi3Config
  sleep 1
  restartPolybar
}

# main
if [ -z "$1" ]; then
  echo "No theme provided"
  exit 1
fi

theme="$1"
found=false
available_themes=("badwolf" "default" "dracula" "grayscale" "gruvbox" "nord")
for item in "${available_themes[@]}"; do
  if [ "$item" = "$theme" ]; then
    echo "Changing theme to $theme ..."
    changeTheme "$theme"
    found=true
    break
  fi
done

if [ $found = false ]; then
  echo "Wrong theme: $theme. Available themes: ${available_themes[*]}"
fi
