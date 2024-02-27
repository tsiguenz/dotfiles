#!/bin/bash
#
set -ue

RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m"

print_info() {
	echo -e "${GREEN}[INFO] $1$NC"
}

print_error() {
	echo -e "${RED}[ERROR] $1$NC"
}

create_dotfiles_symlinks() {
	print_info "Create symlinks for dotfiles..."

	DIR=$(pwd)

	DOTFILES=(
		".vimrc"
		".zshrc"
		".tmux.conf"
		".config/nvim"
		".config/alacritty"
		".config/gdb"
	)

	for dotfile in "${DOTFILES[@]}"; do
		rm -rf "${HOME}/${dotfile:?}"
		ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
	done
}

cleanup() {
	print_info "Cleanup..."
	sudo apt autoremove -yq neovim rustc cargo
	sudo rm -rf /etc/vim
}

setup_rust() {
	print_info "Setup rust..."
	if ! rustc -V 2>/dev/null; then
		curl https://sh.rustup.rs -sSf | sh -s -- -y
		# shellcheck disable=1091
		source "$HOME/.cargo/env"
	fi
}

install_font() {
	print_info "Install font..."
	local PATCHED_FONT_DIR="/usr/share/fonts/DejaVuPatched/"
	if [ ! -f $PATCHED_FONT_DIR ]; then
		sudo mkdir -p $PATCHED_FONT_DIR
		wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
		sudo tar -xf DejaVuSansMono.tar.xz -C $PATCHED_FONT_DIR
		rm -rf DejaVuSansMono.tar.xz
		fc-cache
	fi
}

install_dependancies() {
	print_info "Install dependancies..."
	sudo apt install -yq vim wget curl
	# alacritty
	sudo apt install -yq cmake pkg-config libfreetype6-dev libfontconfig1-dev
	sudo apt install -yq libxcb-xfixes0-dev libxkbcommon-dev python3
	setup_rust
	install_font
}

setup_neovim() {
	print_info "Setup neovim..."
	if [ ! -d "/usr/share/nvim-linux64" ]; then
		wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
		tar -xvf nvim-linux64.tar.gz >/dev/null
		rm -rf nvim-linux64.tar.gz
		sudo mv nvim-linux64 /usr/share/
		sudo ln -s /usr/share/nvim-linux64/bin/nvim /usr/bin/nvim
	fi
}

setup_tmux() {
	print_info "Setup tmux..."
	sudo apt install -yq tmux
	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
		git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
	fi
}

setup_zsh() {
	print_info "Setup zsh..."
	sudo apt install -yq zsh
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh |
			sh -s -- --unattended --keep-zshrc
	fi
	sudo chsh -s /usr/bin/zsh "$USER"
}

setup_alacritty() {
	print_info "Setup alacritty..."
	if [ ! -f "/usr/bin/alacritty" ]; then
		cargo install alacritty
		sudo ln -s "$HOME/.cargo/bin/alacritty" /usr/bin/alacritty
	fi
}

sudo apt update -yq
cleanup
install_dependancies
setup_neovim
setup_tmux
setup_zsh
setup_alacritty
create_dotfiles_symlinks
print_info "Everything is ready!"
