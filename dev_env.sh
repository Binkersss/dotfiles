#!/usr/bin/env bash
git checkout main
git pull 

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
