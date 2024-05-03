#!/bin/bash

DIR=$(pwd)

DOTFILES=(
	"config/nvim"
	"config/gdb"
	"vim"
	"tmux.conf"
	"zshrc"
)

for dotfile in "${DOTFILES[@]}"; do
	echo Create symlink for "${dotfile}"
	dot_file_path="${HOME}"/."${dotfile}"
	rm -rf "$dot_file_path"
	ln -sf "${DIR}/${dotfile}" "$dot_file_path"
done
