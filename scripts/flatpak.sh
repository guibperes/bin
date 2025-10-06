#!/bin/bash

echo -e "# Flatpak installation"
cat $AKIRA_PKG_PATH/flatpak.txt | xargs flatpak install --noninteractive -y flathub
