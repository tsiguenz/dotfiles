#!/bin/bash

./install_requirements.sh

DIR=$(pwd)

DOTFILES=(
	".vimrc"
	".zshrc"
	".tmux.conf"
	".config/nvim"
	".config/gdb"
)

for dotfile in "${DOTFILES[@]}"; do
	echo "Create symlink for ${dotfile}"
	rm -rf "${HOME}/${dotfile:?}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
