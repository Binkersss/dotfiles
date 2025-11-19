#!/usr/bin/env bash
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

REPO_URL="https://github.com/ohmyzsh/ohmyzsh.git"
TARGET_DIR="${PWD}/config/oh-my-zsh"

if [ ! -d "$TARGET_DIR" ] || [ -z "$(ls -A "$TARGET_DIR")" ]; then
	echo "Installing oh-my-zsh since it isn't present..."
	git clone "$REPO_URL" "$TARGET_DIR"
fi

REPO_URL="https://github.com/zsh-users/zsh-autosuggestions.git"
TARGET_DIR="${PWD}/config/oh-my-zsh/custom/plugins/zsh-autosuggestions"

if [ ! -d "$TARGET_DIR" ] || [ -z "$(ls -A "$TARGET_DIR")" ]; then
	echo "Installing zsh-autosuggestions since it isn't present..."
	git clone "$REPO_URL" "$TARGET_DIR"
fi

REPO_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"
TARGET_DIR="${PWD}/config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

if [ ! -d "$TARGET_DIR" ] || [ -z "$(ls -A "$TARGET_DIR")" ]; then
	echo "Installing zsh-syntax-highlighting since it isn't present..."
	git clone "$REPO_URL" "$TARGET_DIR"
fi
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

make_symlink "${PWD}/config/zsh/.zshrc" "$HOME/.zshrc"

make_symlink "${PWD}/config/nvim" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

make_symlink "${PWD}/config/tmux" "${XDG_CONFIG_HOME:-$HOME/.config}/tmux"

make_symlink "${PWD}/config/ghostty" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"

make_symlink "${PWD}/config/hypr" "${XDG_CONFIG_HOME:-$HOME/.config}/hypr"

make_symlink "${PWD}/config/wofi" "${XDG_CONFIG_HOME:-$HOME/.config}/wofi"

make_symlink "${PWD}/config/waybar" "${XDG_CONFIG_HOME:-$HOME/.config}/waybar"

make_symlink "${PWD}/config/thefuck" "${XDG_CONFIG_HOME:-$HOME/.config}/thefuck"

make_symlink "${PWD}/config/dolphin/dolphinrc" "${XDG_CONFIG_HOME:-$HOME/.config}/dolphinrc"

make_symlink "${PWD}/config/systemd/user" "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
hyprctl reload
