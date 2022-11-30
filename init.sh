#!/bin/bash

vim_folder_path=~/.vim/
vimrc_path=~/.vimrc

echo "Copy directory functions/ in $vim_folder_path"
mkdir ~/.vim/functions
cp -iurf functions/ $vim_folder_path

echo "Copy vimrc in $vimrc_path"
cp -iuf vimrc $vimrc_path
