#!/bin/bash

echo "Install requirements..."
./install_requirements.sh

DIR=$(pwd)

DOTFILES=(
	".vimrc"
	".zshrc"
	".tmux.conf"
	".config/nvim"
	".config/gdb"
)

echo "Create symlinks for dotfiles..."

for dotfile in "${DOTFILES[@]}"; do
	echo "Create symlink for ${dotfile}"
	rm -rf "${HOME}/${dotfile:?}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
