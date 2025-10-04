#!/bin/bash
# Akira distro installation script
AKIRA_DIR_NAME=.akira
AKIRA_DIR_PATH=$HOME/$AKIRA_DIR_NAME
AKIRA_CONFIG_PATH=$AKIRA_DIR_PATH/configs
AKIRA_PKG_PATH=$AKIRA_DIR_PATH/packages

HOME_CONFIG_PATH=$HOME/.config

YAY_URL=https://aur.archlinux.org/yay.git
YAY_DIR=$AKIRA_DIR_PATH/yay

GIT_URL_LAZYVIM=https://github.com/guibperes/lazyvim-config
# GIT_URL_AKIRA_GTK=https://github.com/guibperes/akira-gtk-theme

# USER_NAME="Guilherme Beidaki Peres"
# sudo usermod -c $USER_NAME $USER
# echo -e "\n# Akira GTK theme"
# git clone $GIT_URL_AKIRA_GTK $HOME/.themes/Akira

echo -e "# Starting Akira installation script"
echo -e "# Removing Qt/KDE related packages"
sudo pacman -Rns dolphin polkit-kde-agent

echo -e "# Pacman package manager full system update and packages install"
sudo cp $AKIRA_CONFIG_PATH/pacman.conf /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm - <$AKIRA_PKG_PATH/pacman.txt

echo -e "# Yay installation, configuration and packages install"
sudo pacman -S --needed --noconfirm base-devel
git clone $YAY_URL $YAY_DIR
cd $YAY_DIR
makepkg -si --noconfirm
cd $AKIRA_DIR_PATH
rm -rf $YAY_DIR

yay -Y --gendb
cat $AKIRA_PKG_PATH/yay.txt | xargs yay -S --noconfirm

echo -e "# Flatpak installation"
cat $AKIRA_PKG_PATH/flatpak.txt | xargs flatpak install --noninteractive -y flathub

echo -e "# LazyVim install"
git clone $GIT_URL_LAZYVIM $HOME_CONFIG_PATH/nvim

echo -e "# Mise install global tools"
mise use -g node@22

source ./scripts/cp-config.sh

echo -e "# Applying configurations"
sudo usermod -aG docker $USER
sudo chsh -s /bin/fish $USER
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
kitten themes --reload-in all Akira
fc-cache

echo -e "# Systemctl enable and starting services"
cat $AKIRA_PKG_PATH/systemctl-enable.txt | xargs sudo systemctl enable --now

echo -e "# Finished Post installation script"
