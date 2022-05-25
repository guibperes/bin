#!/bin/bash

# Gnome Utils installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME

echo -e "# Gnome Utils installation script"
echo -e "# Clonning guibperes/bin github repository"
git clone -q https://github.com/guibperes/bin.git $BIN_PATH

echo -e "\n# Creating directories if they not exists"
[ ! -d "$HOME/.config" ] &&\
	echo -e "Creating \$HOME/.config directory" &&\
	mkdir $HOME/.config

[ ! -d "$HOME/.config/mpv" ] &&\
	echo -e "Creating \$HOME/.config/mpv directory" &&\
	mkdir $HOME/.config/mpv

echo -e "\n# Copying .XCompose keyboard configuration file"
cp $BIN_PATH/configs/.XCompose $HOME/.XCompose

echo -e "\n# Copying Starship prompt configuration file"
cp $BIN_PATH/configs/starship.toml $HOME/.config/starship.toml

echo -e "\n# Copying MPV configuration file"
cp $BIN_PATH/configs/mpv.conf $HOME/.config/mpv/mpv.conf

echo -e "\n# Adding $BIN_NAME directory to your path"
echo -e "# Add this line to your RC file (.bashrc, .zshrc, etc)\n"
echo -e "export PATH=\"\$PATH:$BIN_PATH\""

