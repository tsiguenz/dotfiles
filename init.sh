#!/bin/bash

DIR=$(pwd)

DOTFILES=(
	".vimrc"
	".tmux.conf"
	".config/nvim"
	".config/gdb"
	".tmux.conf"
)

for dotfile in "${DOTFILES[@]}"; do
	echo Create symlink for "${dotfile}"
	rm -rf "${HOME}/${dotfile:?}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
