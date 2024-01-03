#!/usr/bin/env bash
#github-action genshdoc
#
# @file Setup
# @brief Configures installed system

echo -ne "
-------------------------------------------------------------------------------
CONFIGURING ARCHLINUX SYSTEM
-------------------------------------------------------------------------------
"
source $HOME/infrastructure/configs/setup.conf


echo -ne "
1. Updating base system ... 
"
pacman -S --noconfirm archlinux-keyring

