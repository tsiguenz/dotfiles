#!/bin/bash

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

set -u

# delete neovim
sudo apt autoremove -y neovim
sudo apt install -y vim zsh tmux wget curl sed
sudo rm -rf /etc/vim

# install neovim latest
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
rm -rf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/share/
sudo ln -s /usr/share/nvim-linux64/bin/nvim /usr/bin/nvim

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# add patched font
mkdir -p fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
tar -xf DejaVuSansMono.tar.xz -C fonts
sudo mv fonts/*.ttf /usr/share/fonts
fc-cache
rm -rf fonts DejaVuSansMono.tar.xz

# change bash to zsh
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" $SUDO_USER
sudo chsh -s /usr/bin/zsh $SUDO_USER
