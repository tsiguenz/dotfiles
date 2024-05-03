#!/bin/bash

DIR=$(pwd)

DOTFILES=(
	"vim"
	"tmux.conf"
	"zshrc"
	"config/nvim"
	"config/gdb"
	"config/alacritty"
)

for dotfile in "${DOTFILES[@]}"; do
	echo Create symlink for "${dotfile}"
	dot_file_path="${HOME}"/."${dotfile}"
	rm -rf "$dot_file_path"
	ln -sf "${DIR}/${dotfile}" "$dot_file_path"
done
