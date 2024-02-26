#!/bin/bash

set -u

# delete neovim
sudo apt update -yq
sudo apt autoremove -yq neovim
sudo apt install -yq vim zsh tmux wget curl sed

# install neovim latest
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz >/dev/null
rm -rf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/share/
rm -rf nvim-linux64
sudo ln -s /usr/share/nvim-linux64/bin/nvim /usr/bin/nvim

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# add patched font
mkdir -p fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
tar -xf DejaVuSansMono.tar.xz -C fonts >/dev/null
sudo cp -r fonts/*.ttf /usr/share/fonts
fc-cache
rm -rf fonts DejaVuSansMono.tar.xz

# install ohmyzsh and set to default shell
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh >install_ohmyzsh
chmod +x install_ohmyzsh
./install_ohmyzsh --unattended --keep-zshrc
rm -rf install_ohmyzsh
sudo chsh -s /usr/bin/zsh "$USER"
