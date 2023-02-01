#!/bin/bash

vim_folder_path=~/.vim/
vimrc_path=~/.vimrc
tmux_conf_path=~/.tmux.conf

echo "Copy directory functions/ in $vim_folder_path"
mkdir -p ~/.vim/functions
cp -iurf functions/ $vim_folder_path

echo "Copy vimrc in $vimrc_path"
cp -iuf vimrc $vimrc_path

echo "Copy tmux.conf in $tmux_conf_path"
cp -iuf tmux.conf $tmux_conf_path
