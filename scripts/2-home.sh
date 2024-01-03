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
CONFIG='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
