#! /bin/bash

export https_proxy=socks5://127.0.0.1:1080
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/plugged
