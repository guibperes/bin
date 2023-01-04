#!/bin/bash

# Debian testing post installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME

echo -e "\n# Starting Post installation script"
echo -e "# Clonning guibperes/bin github repository"
git clone -q https://github.com/bin $BIN_PATH

echo -e "# DPKG adding 32 bits architecture"
sudo dpkg --add-architecture i386

echo -e "\n# APT system update and packages installation"
echo -e "# Moving APT sources.list file"
sudo cp $BIN_PATH/configs/apt.sources.list /etc/apt/sources.list

echo -e "# APT update"
sudo apt-get update

echo -e "# APT packages upgrade"
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo -e "# APT packages installation"
sudo apt-get install -y \
        zsh \
	vim \
        mpv \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	kitty \
	build-essential \
	docker.io \
	flatpak \
	gnome-software-plugin-flatpak \
	winbind \
	libavcodec-extra \
	unrar \
	gstreamer1.0-libav \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-vaapi \
	ttf-mscorefonts-installer \
	cups \
	wine \
	winetricks \
	firmware-linux \
	firmware-linux-nonfree \
	libdrm-amdgpu1 \
	xserver-xorg-video-amdgpu \
	mesa-vulkan-drivers \
	libvulkan1 \
	vulkan-tools \
	vulkan-utils \
	vulkan-validationlayers \
	mesa-opencl-icd

echo -e "# APT cleanup"
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo -e "\n# Flatpak installation"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub \
	com.valvesoftware.Steam \
	com.heroicgameslauncher.hgl \
	com.spotify.Client \
	com.discordapp.Discord \
	org.gimp.GIMP \
	org.signal.Signal

echo -e "\n# ZSH installation and configuration"
echo -e "# Oh My ZSH"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

echo -e "# ZInit plugins"
curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | sh

echo -e "# Starship prompt"
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -y -f

echo -e "\n# Docker post install"
sudo usermod -aG docker $USER
sudo systemctl enable docker

echo -e "\n# NVM installation"
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | sh

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

