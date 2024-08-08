#!/bin/bash

# Check if the script is running from its own directory
if [ ! -f "$(basename "$0")" ]; then
    echo "Error: This script must be run from the directory where it is stored."
    echo "Please cd to the script's directory and try again."
    exit 1
fi

# Check if the script is running with sudo privileges
if [ "$EUID" -ne 0 ]; then
    # Check if the user is in the sudo group
    if groups $USER | grep &>/dev/null '\bsudo\b'; then
        echo "You are in the sudo group, but didn't run this script with sudo privileges."
        echo "Please run the script again using: sudo $0"
    else
        echo "You are not in the sudo group."
        echo "Please add your username to the sudoers group and try again."
        echo "You can do this by running: sudo usermod -aG sudo $USER"
    fi
    exit 1
fi

## Update, Upgrade, and Autoremove
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Make .dotfile directories
sudo mkdir -p $HOME/.config
sudo truncate -s 0 /etc/apt/sources.list
sudo cp sources.list /etc/apt/sources.list.d/sources.list
sudo apt update
sudo apt upgrade -y
sudo apt install curl wget gpg apt-transport-https flatpak gnome-software-plugin-flatpak timeshift linux-headers-amd64 xdotool imagemagick chrome-gnome-shell gnome-shell-extension-manager -y
sudo apt install libqt5sql5 libqt5help5 libqt5opengl5 libqt5printsupport5 libqt5xml5 -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


# Uncomment this line to install the proprietary Nvidia driver. This fails back to Xll and there will be no Wayland Support.
#sudo apt install nvidia-driver firmware-misc-nonfree -y

sudo apt -t bookworm-backports install linux-image-amd64 linux-headers-amd64 -y
sudo tee -a /etc/apt/preferences << EOF
Package: linux-image-*
Pin: release a=bookworm-backports
Pin-Priority: 500

Package: linux-headers-*
Pin: release a=bookworm-backports
Pin-Priority: 500
EOF

sudo reboot