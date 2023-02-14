#!/bin/bash

vim_folder_path=~/.vim/
vimrc_path=~/.vimrc
tmux_conf_path=~/.tmux.conf
nvim_folder_path=~/.config/nvim/

echo "Copy directory functions/ in $vim_folder_path"
mkdir -p ~/.vim/functions
cp -iurf functions/ $vim_folder_path

echo "Copy vimrc in $vimrc_path"
cp -iuf vimrc $vimrc_path

echo "Copy tmux.conf in $tmux_conf_path"
cp -iuf tmux.conf $tmux_conf_path

echo "Copy nvim config to $nvim_folder_path"
mkdir -p $nvim_folder_path
cp -iurf nvim_config $nvim_folder_path/init.vim
