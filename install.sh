#!/bin/bash

# Debian testing post installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME
APT_PATH=$BIN_PATH/configs/apt

echo -e "\n# Starting Post installation script"
echo -e "# Installing git"
sudo apt install -y git

echo -e "\n# Clonning guibperes/bin github repository"
git clone -q https://github.com/guibperes/bin $BIN_PATH

echo -e "# DPKG adding 32 bits architecture"
sudo dpkg --add-architecture i386

echo -e "\n# APT system update and packages installation"
echo -e "# Moving APT sources.list file"
sudo cp $APT_PATH/sources.list /etc/apt/sources.list
sudo cp $APT_PATH/vscode.list /etc/apt/sources.list.d/vscode.list
sudo cp $APT_PATH/brave-browser.list /etc/apt/sources.list.d/brave-browser.list
sudo cp $APT_PATH/brave-browser-archive-keyring.gpg /usr/share/keyrings/brave-browser-archive-keyring.gpg

echo -e "# APT update"
sudo apt update

echo -e "# APT packages upgrade"
sudo apt upgrade -y
sudo apt dist-upgrade -y

echo -e "# APT packages installation"
sudo apt install -y \
	curl \
	ca-certificates \
	gnupg \
	lsb-release \
	build-essential \
	docker.io \
	gstreamer1.0-libav \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-vaapi \
	libdrm-amdgpu1 \
	xserver-xorg-video-amdgpu \
	mesa-vulkan-drivers \
	libvulkan1 \
	vulkan-tools \
	vulkan-validationlayers \
	mesa-opencl-icd \
	firmware-linux \
	firmware-linux-nonfree \
	wine \
	winetricks \
	winbind \
	libavcodec-extra \
	unrar \
	ttf-mscorefonts-installer \
	cups \
	flatpak \
	gnome-software-plugin-flatpak \
	zsh \
	vim \
	mpv \
	kitty \
	nala \
	yt-dlp \
	chrony \
	code \
	brave-browser

echo -e "# APT cleanup"
sudo apt autoremove -y
sudo apt autoclean -y

echo -e "\n# Flatpak installation"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --noninteractive -y flathub \
	com.valvesoftware.Steam \
	com.heroicgameslauncher.hgl \
	com.spotify.Client \
	com.discordapp.Discord \
	org.gimp.GIMP \
	org.signal.Signal \
	org.ferdium.Ferdium

echo -e "\n# Nala package manager configuration"
nala --install-completion zsh

echo -e "\n# NTP clock setup and sync"
sudo systemctl enable --now chrony
sudo timedatectl set-ntp true

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

echo -e "\n# Gnome configurations"
echo -e "\n# Papirus icon theme install"
curl -fsSL https://git.io/papirus-icon-theme-install | sh

echo -e "\n# Copying configuration files"
echo -e "# .XCompose"
cp $BIN_PATH/configs/.XCompose $HOME/.XCompose

echo -e "# starship.toml"
cp $BIN_PATH/configs/starship.toml $HOME/.config/starship.toml

echo -e "# mpv.conf"
mkdir -p $HOME/.config/mpv
cp $BIN_PATH/configs/mpv.conf $HOME/.config/mpv/mpv.conf

echo -e "# .zshrc"
cp $BIN_PATH/configs/.zshrc $HOME/.zshrc

echo -e "# .kitty.conf"
mkdir -p $HOME/.config/kitty
cp $BIN_PATH/configs/tokyo-night.conf $HOME/.config/kitty/tokyo-night.conf
cp $BIN_PATH/configs/kitty.conf $HOME/.config/kitty/kitty.conf

echo -e "\n# Finished Post installation script"

