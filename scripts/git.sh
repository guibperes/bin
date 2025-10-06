#!/bin/bash

echo -e "# Git configuration and aliases"
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL
git config --global alias.a 'add'
git config --global alias.ps 'push'
git config --global alias.pl 'pull'
git config --global alias.l 'log'
git config --global alias.c 'commit -m'
git config --global alias.s 'status'
git config --global alias.co 'checkout'
git config --global alias.b 'branch'
