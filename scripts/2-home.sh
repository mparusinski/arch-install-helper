#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
#
# @file Home
# @brief Configures home directory (run as user)

echo -ne "
-------------------------------------------------------------------------------
CONFIGURING ARCHLINUX SYSTEM
-------------------------------------------------------------------------------
"
source $HOME/infrastructure/configs/setup.conf

echo -ne "
-------------------------------------------------------------------------------
1. Cloning user dot files
-------------------------------------------------------------------------------
"
sudo pacman -S --noconfirm fzf
CONFIG="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
pushd $HOME
rm -f $HOME/.bashrc $HOME/.zshrc $HOME/.cfg
echo ".cfg" >> .gitignore
git clone --bare --recursive git@github.com:mparusinski/dotfiles.git $HOME/.cfg
$CONFIG checkout
$CONFIG config --local status.showUntrackedFiles no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
popd
