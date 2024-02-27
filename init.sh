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

check_root_and_set_home_user() {
	if [ "$(id -u)" != "0" ]; then
		print_error "Can't run this script without root permissions!"
		exit 1
	fi
	USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
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
		runuser -l "$SUDO_USER" rm -rf "${USER_HOME}/${dotfile:?}"
		runuser -l "$SUDO_USER" ln -sf "${DIR}/${dotfile}" "${USER_HOME}/${dotfile}"
	done
}

cleanup() {
	print_info "Cleanup..."
	apt autoremove -yq neovim rustc cargo
	rm -rf /etc/vim
}

setup_rust() {
	print_info "Setup rust..."
	if ! rustc -V; then
		curl https://sh.rustup.rs -sSf >install_rust.sh
		chmod +x install_rust.sh
		runuser -u "$SUDO_USER" -- ./install_rust.sh -y
		runuser -u "$SUDO_USER" -- bash -c "source $USER_HOME/.cargo/env"
		rm -rf install_rust.sh
	fi
}

install_font() {
	print_info "Install font..."
	local PATCHED_FONT_DIR="/usr/share/fonts/DejaVuPatched/"
	if [ ! -f $PATCHED_FONT_DIR ]; then
		mkdir -p $PATCHED_FONT_DIR
		wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
		tar -xf DejaVuSansMono.tar.xz -C $PATCHED_FONT_DIR
		rm -rf DejaVuSansMono.tar.xz
		fc-cache
	fi
}

install_dependancies() {
	print_info "Install dependancies..."
	apt install -yq vim wget curl
	# alacritty
	apt install -yq cmake pkg-config libfreetype6-dev libfontconfig1-dev
	apt install -yq libxcb-xfixes0-dev libxkbcommon-dev python3
	setup_rust
	install_font
}

setup_neovim() {
	print_info "Setup neovim..."
	if [ ! -d "/usr/share/nvim-linux64" ]; then
		wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
		tar -xvf nvim-linux64.tar.gz >/dev/null
		rm -rf nvim-linux64.tar.gz
		mv nvim-linux64 /usr/share/
		ln -s /usr/share/nvim-linux64/bin/nvim /usr/bin/nvim
	fi
}

setup_tmux() {
	print_info "Setup tmux..."
	apt install -yq tmux
	if [ ! -d "$USER_HOME/.tmux/plugins/tpm" ]; then
		git clone https://github.com/tmux-plugins/tpm "$USER_HOME/.tmux/plugins/tpm"
	fi
}

setup_zsh() {
	print_info "Setup zsh..."
	apt install -yq zsh
	if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
		runuser -l "$SUDO_USER" curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended --keep-zshrc
	fi
	chsh -s /usr/bin/zsh "$USER"
}

setup_alacritty() {
	print_info "Setup alacritty..."
	if [ ! -f "/usr/bin/alacritty" ]; then
		runuser -l "$SUDO_USER" cargo install alacritty
		ln -s "$USER_HOME/.cargo/bin/alacritty" /usr/bin/alacritty
	fi
}

check_root_and_set_home_user
apt update -yq
cleanup
install_dependancies
setup_neovim
setup_tmux
setup_zsh
setup_alacritty
create_dotfiles_symlinks
print_info "Everything is ready!"
