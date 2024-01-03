#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
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
-------------------------------------------------------------------------------
1. Updating base system ... 
-------------------------------------------------------------------------------
"
# Keyring must be updated before performing upgrade otherwise we get complains
# about corrupted packages
pacman -Sy --noconfirm archlinux-keyring
pacman -Su

echo -ne "
-------------------------------------------------------------------------------
2. Setting up mirrors for optimal download
-------------------------------------------------------------------------------
"
REFLECTOR_CONF=/etc/xdg/reflector/reflector.conf
pacman -S --noconfirm --needed pacman-contrib curl
pacman -S --noconfirm --needed reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.back
sed -i "$ a # Specify desired countries" $REFLECTOR_CONF
sed -i "$ a --country France,Germany,Switzerland" $REFLECTOR_CONF
systemctl enable --now reflector

echo -ne "
-------------------------------------------------------------------------------
3. Configuring SSH server (if needed)
-------------------------------------------------------------------------------
"
if [[ ! -z "$SERVER" ]]; then
    SSHD_CONFIG=/etc/ssh/sshd_config
    sed -iE "s/#?Port 22/Port 2222/gm" $SSHD_CONFIG
    sed -iE "s/#?PermitRootLogin (no|yes)/PermitRootLogin no/gm" $SSHD_CONFIG
    sed -iE "s/#?PasswordAuthentication (no|yes)/PasswordAuthentication no/gm" $SSHD_CONFIG
fi

echo -ne "
-------------------------------------------------------------------------------
3. Setting up users
-------------------------------------------------------------------------------
"
USERNAME=michalparusinski
pacman -S --noconfirm zsh vim
echo "Please check wheel group can run sudo commands"
read -n 1 -s
EDITOR=vim visudo
useradd -m -G wheel -s /bin/zsh $USERNAME
echo "Please enter password"
read -n 1 -s
passwd $USERNAME
if [[ ! -z "$SERVER" ]]; then
    mkdir -p /home/$USERNAME/.ssh/
    cp configs/authorized_keys /home/$USERNAME/.ssh/authorized_keys
    chown $USERNAME /home/$USERNAME/.ssh/authorized_keys
fi

