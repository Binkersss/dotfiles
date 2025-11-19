#!/usr/bin/env bash
git checkout main
git pull 

echo "Updating system..."
#sudo pacman -Syu --noconfirm

echo "Installing/Updating base packages"
if [[ -f "./base.packages" ]]; then
	packages=$(grep -v '^#' "./base.packages" | grep -v '^$' | tr '\n' ' ')
	if [[ -n "$packages" ]]; then
		echo "$(sudo pacman -S --needed --noconfirm $packages)"
	fi
else
	echo "Warning: base.packages not found"
fi

echo "Make sure to install the packages in aur.packages separately!"

make_symlink() {
    local target="$1"
    local linkpath="$2"

    if [ -z "$target" ] || [ -z "$linkpath" ]; then
        echo  "Error at make_symlink"
        return 1
    fi
    echo "Linking $linkpath to $target"
    ln -sfn "$target" "$linkpath"
}

make_symlink "${PWD}/config/nvim" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

make_symlink "${PWD}/config/tmux" "${XDG_CONFIG_HOME:-$HOME/.config}/tmux"

make_symlink "${PWD}/config/ghostty" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"

make_symlink "${PWD}/config/hypr" "${XDG_CONFIG_HOME:-$HOME/.config}/hypr"

make_symlink "${PWD}/config/wofi" "${XDG_CONFIG_HOME:-$HOME/.config}/wofi"

make_symlink "${PWD}/config/waybar" "${XDG_CONFIG_HOME:-$HOME/.config}/waybar"

make_symlink "${PWD}/config/dolphin/dolphinrc" "${XDG_CONFIG_HOME:-$HOME/.config}/dolphinrc"
