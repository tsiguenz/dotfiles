#!/bin/bash

set -ue

RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m"
PWD=$(pwd)

print_info() {
	echo -e "${GREEN}[INFO] $1$NC" >&3
}

print_error() {
	echo -e "${RED}[ERROR] $1$NC" >&3
}

check_root_and_set_home_user() {
	if [ "$(id -u)" != "0" ]; then
		print_error "Can't run this script without root permissions!"
		exit 1
	fi
	USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
}

cleanup() {
	print_info "Cleanup..."
	apt autoremove -yq neovim rustc cargo
	rm -rf /etc/vim
}

install_rust() {
	print_info "Installing rust..."
	if ! su -c "rustc -V" "$SUDO_USER"; then
		local INSTALL_FILE=$PWD/install_rust.sh
		wget https://sh.rustup.rs -O "$INSTALL_FILE"
		chmod +x "$INSTALL_FILE"
		runuser -u "$SUDO_USER" -- "$INSTALL_FILE" -y
		runuser -u "$SUDO_USER" -- bash -c "source $USER_HOME/.cargo/env"
		rm -rf "$INSTALL_FILE"
		print_info "rust is now installed!"
	else
		print_info "rust is already installed!"
	fi
}

install_font() {
	print_info "Installing the font..."
	local PATCHED_FONT_DIR="/usr/share/fonts/DejaVuPatched/"
	if [ ! -d $PATCHED_FONT_DIR ]; then
		mkdir -p $PATCHED_FONT_DIR
		wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
		tar -xf DejaVuSansMono.tar.xz -C $PATCHED_FONT_DIR
		rm -rf DejaVuSansMono.tar.xz
		fc-cache
		print_info "The font is now installed!"
	else
		print_info "The font is already installed!"
	fi
}

install_dependancies() {
	print_info "Installing dependancies..."
	apt install -yq vim wget curl
	# alacritty
	apt install -yq cmake pkg-config libfreetype6-dev libfontconfig1-dev
	apt install -yq libxcb-xfixes0-dev libxkbcommon-dev python3
	install_rust
	install_font
}

install_neovim() {
	print_info "Installing neovim..."
	if [ ! -d "/usr/share/nvim-linux64" ]; then
		wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
		tar -xvf nvim-linux64.tar.gz >/dev/null
		rm -rf nvim-linux64.tar.gz
		mv nvim-linux64 /usr/share/
		ln -sf /usr/share/nvim-linux64/bin/nvim /usr/bin/nvim
		print_info "neovim is now installed!"
	else
		print_info "neovim is already installed!"
	fi
}

install_tmux() {
	print_info "Installing tmux and tmux plugin manager..."
	apt install -yq tmux
	if [ ! -d "$USER_HOME/.tmux/plugins/tpm" ]; then
		runuser -l "$SUDO_USER" -c "git clone https://github.com/tmux-plugins/tpm $USER_HOME/.tmux/plugins/tpm"
		print_info "tmux plugin manager is now installed!"
	else
		print_info "tmux plugin manager is already installed!"
	fi
}

install_zsh() {
	print_info "Installing zsh..."
	apt install -yq zsh
	if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
		local INSTALL_FILE="$PWD"/install_omzsh.sh
		wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O "$INSTALL_FILE"
		chmod +x "$INSTALL_FILE"
		runuser -l "$SUDO_USER" -- "$INSTALL_FILE" --unattended --keep-zshrc
		rm -rf "$INSTALL_FILE"
		print_info "zsh is now installed!"
	else
		print_info "zsh is already installed!"
	fi
	chsh -s /usr/bin/zsh "$USER"
}

install_alacritty() {
	print_info "Installing alacritty..."
	if ! su -c "alacritty -V" "$SUDO_USER"; then
		su -c "cargo install alacritty" "$SUDO_USER"
		ln -sf "$USER_HOME/.cargo/bin/alacritty" /usr/bin/alacritty
		print_info "alacritty is now installed!"
	else
		print_info "alacritty is already installed!"
	fi
}

# save stdout in fd 3 and redirect everything in .log
exec 3>&1 &>.log
check_root_and_set_home_user
apt update -yq
cleanup
install_dependancies
install_neovim
install_tmux
install_zsh
install_alacritty
print_info "Everything is installed!"
