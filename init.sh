#!/bin/bash

vim_folder_path=~/.vim/
vimrc_path=~/.vimrc
tmux_conf_path=~/.tmux.conf
config_folder_path=~/.config/

echo "Copy directory functions/ in $vim_folder_path"
mkdir -p ~/.vim/functions
cp -iurf functions/ $vim_folder_path

echo "Copy vimrc in $vimrc_path"
cp -iuf vimrc $vimrc_path

echo "Copy tmux.conf in $tmux_conf_path"
cp -iuf tmux.conf $tmux_conf_path

echo "Copy nvim config to $config_folder_path"
mkdir -p $config_folder_path
cp -iurf nvim $config_folder_path

echo "Copy gdb config to $config_folder_path"
mkdir -p $config_folder_path/gdb
cp -iurf gdbinit $config_folder_path/gdb/
