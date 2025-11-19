#! /bin/bash

WALLPAPER_PATH=$(find "$HOME/dev/env/config/wallpapers/" | shuf -n 1)
cp "$WALLPAPER_PATH" "$HOME/dev/env/config/hypr/wallpaper_effects/.wallpaper_current"

