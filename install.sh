#!/bin/bash

# ArchLinux post installation script
# TODO
# - nvm install --lts
# - Keyboard set English (US, alt. intl.) and English (US)
# - Keyboard shorcut open kitty terminal Super+T
# - Keyboard shorcut open nautilus Super+F
# - Setting user display name and picture
# - Removing default not used apps
# - Ferdium config
# - Hanbrake config
# - Papirus icon set
# - Weather setting city and celsius degree
# - Extensions install and config
# - appindicatorsupport@rgcjonas.gmail.com
# - dash-to-dock@micxgx.gmail.com
# - vertical-overview@RensAlthuis.github.com
# - Vitals@CoreCoding.com
# - WallpaperSwitcher@Rishu

BIN_NAME=.bin
BIN_PATH=$HOME/$BIN_NAME

echo -e "\n# Starting Post installation script"
echo -e "\n# Clonning guibperes/bin github repository"
git clone -q https://github.com/guibperes/bin $BIN_PATH

echo -e "\n# Pacman package manager configuration"
sudo cp $BIN_PATH/configs/pacman.conf /etc/pacman.conf

echo -e "# Full system update"
sudo pacman -Syu --noconfirm

echo -e "# Packages installation"
sudo pacman -S --noconfirm - < $BIN_PATH/packages/pacman.txt

echo -e "# Yay AUR package manager installation"
sudo pacman -S --needed --noconfirm base-devel
git clone -q https://aur.archlinux.org/yay.git $BIN_PATH/yay
cd $BIN_PATH/yay
makepkg -si --noconfirm
cd $BIN_PATH
rm -rf $BIN_PATH/yay
yay -Y --gendb

echo -e "# Yay packages installation"
cat $BIN_PATH/packages/yay.txt | xargs yay -S --noconfirm

echo -e "\n# Flatpak installation"
cat $BIN_PATH/packages/flatpak.txt | xargs flatpak install --noninteractive -y flathub

echo -e "\n# ZSH installation and configuration"
echo -e "# Oh My ZSH"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

echo -e "# ZInit plugins"
curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | sh

echo -e "# Starship prompt"
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -y -f

echo -e "\n# NVM installation"
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

echo -e "\n# Papirus icon theme install"
curl -fsSL https://git.io/papirus-icon-theme-install | sh

echo -e "\n# Docker post install"
sudo usermod -aG docker $USER
sudo systemctl enable --now docker

echo -e "\n# Changing user shell to ZSH"
sudo chsh -s /bin/zsh $USER

echo -e "\n# Bluetooth service deamon start"
sudo systemctl enable bluetooth.service --now

echo -e "\n# Pop Shell keyboard shortcuts config"
yes | /usr/share/gnome-shell/extensions/pop-shell\@system76.com/scripts/configure.sh

echo -e "\n# Font cache update"
fc-cache -fv

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

