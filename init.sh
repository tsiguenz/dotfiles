#!/bin/bash

vim_folder_path=~/.vim/
vimrc_path=~/.vimrc

echo "Copy directory functions/ in $vim_folder_path"
cp -irf functions/ $vim_folder_path

echo "Copy vimrc in $vimrc_path"
cp -if vimrc $vimrc_path
