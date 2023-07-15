#! /bin/bash

cd ~/.vim 
export https_proxy=socks5://127.0.0.1:1080
git clone https://github.com/tomasr/molokai.git
cd molokai/
cp -r colors ../
