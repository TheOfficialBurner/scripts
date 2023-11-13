#!/bin/bash

# Install dependencies
apt update
apt install -y neovim curl git exuberant-ctags nodejs npm python3-pip

npm install -g yarn -y
pip3 install jedi

# Install Neovim plugins and configuration files
mkdir -p ~/.config/nvim
curl -L -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/TheOfficialBurner/config-files/main/init.vim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

cd ~/.local/share/nvim/plugged/coc.nvim/
yarn install
yarn build

# Install plugins using vim-plug
cd ~/.config/nvim
nvim +PlugInstall +qall
