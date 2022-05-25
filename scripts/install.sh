#!/bin/bash

# Gnome Utils installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME

echo -e "# Gnome Utils installation script"
echo -e "# Clonning guibperes/bin github repository"
git clone -q https://github.com/guibperes/bin.git $BIN_PATH

echo -e "\n# Moving .XCompose file to HOME directory"
mv $BIN_PATH/.XCompose $HOME

echo -e "\n# Adding $BIN_NAME directory to your path"
echo -e "# Add this line to your RC file (.bashrc, .zshrc, etc)\n"
echo -e "export PATH=\"\$PATH:$BIN_PATH\""

