#!/bin/bash

set -u

sudo apt update -yq

# clean and install dependancies
sudo apt autoremove -yq neovim
sudo apt install -yq vim zsh tmux wget curl sed
sudo rm -rf /etc/vim

# install neovim latest
if [ ! -f "/usr/share/nvim-linux64" ]; then
	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	tar -xvf nvim-linux64.tar.gz >/dev/null
	rm -rf nvim-linux64.tar.gz
	sudo mv nvim-linux64 /usr/share/
	rm -rf nvim-linux64
	sudo ln -s /usr/share/nvim-linux64/bin/nvim /usr/bin/nvim
fi

# install tmux plugin manager
if [ ! -f "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# add patched font
PATCHED_FONT_DIR="/usr/share/fonts/DejaVuPatched/"
if [ ! -f $PATCHED_FONT_DIR ]; then
	sudo mkdir -p $PATCHED_FONT_DIR
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
	sudo tar -xf DejaVuSansMono.tar.xz -C $PATCHED_FONT_DIR
	rm -rf DejaVuSansMono.tar.xz
	fc-cache
fi

# install ohmyzsh and set to default shell
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended --keep-zshrc
sudo chsh -s /usr/bin/zsh "$USER"

# install rust
if ! rustc -V 2>/dev/null; then
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	source "$HOME/.cargo/env"
fi

# install alacritty
sudo apt install -yq cmake pkg-config libfreetype6-dev libfontconfig1-dev \
	libxcb-xfixes0-dev libxkbcommon-dev python3
cargo install alacritty
sudo ln -s ~/.cargo/bin/alacritty /usr/bin/alacritty
