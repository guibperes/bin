#!/bin/bash
# Akira distro installation script
AKIRA_DIR_NAME=.akira
AKIRA_DIR_PATH=$HOME/$AKIRA_DIR_NAME
USER_NAME="Guilherme Beidaki Peres"

echo -e "\n# Starting Akira installation script"
echo -e "\n# Clonning Akira repository"
git clone https://github.com/guibperes/bin $AKIRA_DIR_PATH

echo -e "\n# Pacman package manager full system update and packages install"
sudo cp $AKIRA_DIR_PATH/configs/pacman.conf /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm - <$AKIRA_DIR_PATH/packages/pacman.txt

echo -e "\n# Yay installation, configuration and packages install"
sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/yay.git $AKIRA_DIR_PATH/yay
cd $AKIRA_DIR_PATH/yay
makepkg -si --noconfirm
cd $AKIRA_DIR_PATH
rm -rf $AKIRA_DIR_PATH/yay

yay -Y --gendb
cat $AKIRA_DIR_PATH/packages/yay.txt | xargs yay -S --noconfirm

echo -e "\n# Flatpak installation"
cat $AKIRA_DIR_PATH/packages/flatpak.txt | xargs flatpak install --noninteractive -y flathub

echo -e "\n# LazyVim install"
git clone https://github.com/guibperes/lazyvim-config $HOME/.config/nvim

echo -e "\n# Mise install global tools"
mise use -g node@22

echo -e "\n# Systemctl enable and starting services"
cat $AKIRA_DIR_PATH/packages/systemctl-enable.txt | xargs sudo systemctl enable --now

echo -e "\n# User configurations"
sudo usermod -aG docker $USER
sudo usermod -c $USER_NAME $USER
sudo chsh -s /bin/fish $USER
fc-cache -fv

echo -e "\n# Copying configuration files"
mkdir -p $HOME/.config/mpv $HOME/.config/kitty $HOME/.config/kitty/themes $HOME/.config/fish $HOME/.config/spotify-player

cp $AKIRA_DIR_PATH/configs/.XCompose $HOME/.XCompose
cp $AKIRA_DIR_PATH/configs/starship.toml $HOME/.config/starship.toml
cp $AKIRA_DIR_PATH/configs/mpv.conf $HOME/.config/mpv/mpv.conf
cp $AKIRA_DIR_PATH/configs/config.fish $HOME/.config/fish/config.fish
cp $AKIRA_DIR_PATH/configs/kitty.conf $HOME/.config/kitty/kitty.conf
cp $AKIRA_DIR_PATH/configs/akira/akira.conf $HOME/.config/kitty/themes/akira.conf
cp $AKIRA_DIR_PATH/configs/spotify.toml $HOME/.config/spotify-player/app.toml

echo -e "\n# Akira theme set"
kitten themes --reload-in all Akira

echo -e "\n# Finished Post installation script"
