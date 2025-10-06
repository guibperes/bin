#!/bin/bash

echo -e "# Pacman package manager full system update and packages install"
sudo cp $AKIRA_CONFIG_PATH/pacman.conf /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm - <$AKIRA_PKG_PATH/pacman.txt
