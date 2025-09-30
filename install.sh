#!/bin/bash
# ArchLinux post installation script
BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME
USER_NAME="Guilherme Beidaki Peres"

echo -e "\n# Starting Post installation script"
echo -e "\n# Clonning guibperes/bin github repository"
git clone https://github.com/guibperes/bin $BIN_PATH

echo -e "\n# Pacman package manager full system update and packages install"
sudo cp $BIN_PATH/configs/pacman.conf /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm - <$BIN_PATH/packages/pacman.txt

echo -e "\n# Yay AUR package manager installation, configuration and package install"
sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/yay.git $BIN_PATH/yay
cd $BIN_PATH/yay
makepkg -si --noconfirm
cd $BIN_PATH
rm -rf $BIN_PATH/yay

yay -Y --gendb
cat $BIN_PATH/packages/yay.txt | xargs yay -S --noconfirm

echo -e "\n# Flatpak installation"
cat $BIN_PATH/packages/flatpak.txt | xargs flatpak install --noninteractive -y flathub

echo -e "\n# LazyVim install"
git clone https://github.com/guibperes/lazyvim-config $HOME/.config/nvim

echo -e "\n# Systemctl enable and starting services"
cat $BIN_PATH/packages/systemctl-enable.txt | xargs sudo systemctl enable --now

echo -e "\n# User configurations"
sudo usermod -aG docker $USER
sudo usermod -c $USER_NAME $USER
sudo chsh -s /bin/fish $USER
fc-cache -fv

echo -e "\n# Copying configuration files"
mkdir -p $HOME/.config/mpv $HOME/.config/kitty $HOME/.config/fish

cp $BIN_PATH/configs/.XCompose $HOME/.XCompose
cp $BIN_PATH/configs/starship.toml $HOME/.config/starship.toml
cp $BIN_PATH/configs/mpv.conf $HOME/.config/mpv/mpv.conf
cp $BIN_PATH/configs/config.fish $HOME/.config/fish/config.fish
cp $BIN_PATH/configs/tokyo-night.conf $HOME/.config/kitty/tokyo-night.conf
cp $BIN_PATH/configs/kitty.conf $HOME/.config/kitty/kitty.conf

echo -e "\n# Finished Post installation script"
