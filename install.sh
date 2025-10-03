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

echo -e "\n# Starting Akira installation script"
echo -e "\n# Pacman package manager full system update and packages install"
sudo cp $AKIRA_CONFIG_PATH/pacman.conf /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm - <$AKIRA_PKG_PATH/pacman.txt

echo -e "\n# Yay installation, configuration and packages install"
sudo pacman -S --needed --noconfirm base-devel
git clone $YAY_URL $YAY_DIR
cd $YAY_DIR
makepkg -si --noconfirm
cd $AKIRA_DIR_PATH
rm -rf $YAY_DIR

yay -Y --gendb
cat $AKIRA_PKG_PATH/yay.txt | xargs yay -S --noconfirm

echo -e "\n# Flatpak installation"
cat $AKIRA_PKG_PATH/flatpak.txt | xargs flatpak install --noninteractive -y flathub

echo -e "\n# LazyVim install"
git clone $GIT_URL_LAZYVIM $HOME_CONFIG_PATH/nvim

echo -e "\n# Mise install global tools"
mise use -g node@22

echo -e "\n# Copying configuration files"
mkdir -p \
  $HOME_CONFIG_PATH/fastfetch \
  $HOME_CONFIG_PATH/fish \
  $HOME_CONFIG_PATH/hypr \
  $HOME_CONFIG_PATH/kitty \
  $HOME_CONFIG_PATH/kitty/themes \
  $HOME_CONFIG_PATH/mpv \
  $HOME_CONFIG_PATH/spotify-player \
  $HOME_CONFIG_PATH/waybar \
  $HOME_CONFIG_PATH/wofi

cp -r $AKIRA_CONFIG_PATH/fastfetch $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/fish $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/hypr $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/kitty $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/mpv $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/spotify-player $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/waybar $HOME_CONFIG_PATH
cp -r $AKIRA_CONFIG_PATH/wofi $HOME_CONFIG_PATH

cp $AKIRA_CONFIG_PATH/.XCompose $HOME/.XCompose
cp $AKIRA_CONFIG_PATH/starship.toml $HOME_CONFIG_PATH

echo -e "\n# Applying configurations"
sudo usermod -aG docker $USER
sudo chsh -s /bin/fish $USER
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
kitten themes --reload-in all Akira
fc-cache

echo -e "\n# Systemctl enable and starting services"
cat $AKIRA_PKG_PATH/systemctl-enable.txt | xargs sudo systemctl enable --now

echo -e "\n# Finished Post installation script"
