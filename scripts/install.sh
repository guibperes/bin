#!/bin/bash

# Post installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME

echo -e "# Starting Post installation script"
echo -e "# APT system update and packages installation"
echo -e "# APT update"
sudo apt-get update > /dev/null

echo -e "# APT packages upgrade"
sudo apt-get upgrade -y > /dev/null

echo -e "# APT packages installation"
sudo apt-get install -y \
        zsh \
	git \
        xclip \
        mpv \
        > /dev/null

echo -e "# APT cleanup"
sudo apt-get autoremove -y > /dev/null
sudo apt-get autoclean -y > /dev/null

echo -e "\n# ZSH installation and configuration"
echo -e "# Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "# ZInit plugins"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

echo -e "# Starship prompt"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo -e "\n# Docker installation"
sh -c "$(curl -fsSL https://get.docker.com)"
sudo usermod -aG docker $USER
sudo systemctl enable docker

echo -e "\n# NVM installation"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)"

echo -e "\n# Clonning guibperes/bin github repository"
git clone -q https://github.com/guibperes/bin.git $BIN_PATH

echo -e "\n# Creating directories if they not exists"
[ ! -d "$HOME/.config" ] && \
	echo -e "# Creating \$HOME/.config directory" && \
	mkdir $HOME/.config

[ ! -d "$HOME/.config/mpv" ] && \
	echo -e "# Creating \$HOME/.config/mpv directory" && \
	mkdir $HOME/.config/mpv

echo -e "\n# Gnome configurations"
echo -e "# Setting Gnome Weather to celsius temperature unit"
gsettings set org.gnome.GWeather temperature-unit "'centigrade'"
gsettings set org.gnome.GWeather4 temperature-unit "'centigrade'"

echo -e "\n# Copying configuration files"
echo -e "# .XCompose"
cp $BIN_PATH/configs/.XCompose $HOME/.XCompose

echo -e "# starship.toml"
cp $BIN_PATH/configs/starship.toml $HOME/.config/starship.toml

echo -e "# mpv.conf"
cp $BIN_PATH/configs/mpv.conf $HOME/.config/mpv/mpv.conf

echo -e "# .zshrc"
cp $BIN_PATH/configs/.zshrc $HOME/.zshrc

echo -e "\n# Finished Post installation script"

