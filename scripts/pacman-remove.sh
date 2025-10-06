#!/bin/bash

echo -e "# Removing Qt/KDE related packages"
sudo pacman -Rns --noconfirm dolphin polkit-kde-agent
