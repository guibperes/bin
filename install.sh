#!/bin/bash

# Post installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME

echo -e "\n# Starting Post installation script"
echo -e "# APT system update and packages installation"
echo -e "# APT update"
sudo apt-get update > /dev/null

echo -e "# APT packages upgrade"
sudo apt-get upgrade -y > /dev/null

echo -e "# APT packages installation"
sudo apt-get install -y \
        zsh \
	git \
        mpv \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	kitty \
	build-essential \
        > /dev/null

echo -e "# APT cleanup"
sudo apt-get autoremove -y > /dev/null
sudo apt-get autoclean -y > /dev/null

echo -e "\n# ZSH installation and configuration"
echo -e "# Oh My ZSH"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh > /dev/null

echo -e "# ZInit plugins"
curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | sh > /dev/null

echo -e "# Starship prompt"
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -y -f

echo -e "\n# Docker installation"
curl -fsSL https://get.docker.com | sh

sudo usermod -aG docker $USER
sudo systemctl enable docker > /dev/null

echo -e "\n# NVM installation"
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh > /dev/null

echo -e "\n# Clonning guibperes/bin github repository"
git clone -q https://github.com/guibperes/bin.git $BIN_PATH

echo -e "\n# Changing user shell to ZSH"
sudo chsh -s /bin/zsh $USER

echo -e "\n# Creating directories if they not exists"
[ ! -d "$HOME/.config" ] && \
	echo -e "# Creating \$HOME/.config directory" && \
	mkdir $HOME/.config

[ ! -d "$HOME/.config/mpv" ] && \
	echo -e "# Creating \$HOME/.config/mpv directory" && \
	mkdir $HOME/.config/mpv

[ ! -d "$HOME/.config/kitty" ] && \
	echo -e "# Creating \$HOME/.config/kitty directory" && \
	mkdir $HOME/.config/kitty

echo -e "\n# Gnome configurations"
echo -e "\n# Papirus icon theme install"
curl -fsSL https://git.io/papirus-icon-theme-install | sh

echo -e "\n# Copying configuration files"
echo -e "# .XCompose"
cp $BIN_PATH/configs/.XCompose $HOME/.XCompose

echo -e "# starship.toml"
cp $BIN_PATH/configs/starship.toml $HOME/.config/starship.toml

echo -e "# mpv.conf"
cp $BIN_PATH/configs/mpv.conf $HOME/.config/mpv/mpv.conf

echo -e "# .zshrc"
cp $BIN_PATH/configs/.zshrc $HOME/.zshrc

echo -e "# .kitty.conf"
cp $BIN_PATH/configs/gruvbox-dark.conf $HOME/.config/kitty/gruvbox-dark.conf
cp $BIN_PATH/configs/kitty.conf $HOME/.config/kitty/kitty.conf

echo -e "\n# Finished Post installation script"

