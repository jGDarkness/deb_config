#! /bin/bash

# Baseline Dependencies

## Update, Upgrade, and Dist-upgrade
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade
sudo apt autoremove

# Make .dotfile directories
mkdir -p $HOME/.config

sudo truncate -s 0 /etc/apt/sources.list

sudo cp sources.list /etc/apt/sources.list.d/sources.list

sudo get update

sudo apt upgrade -y

sudo apt install wget gpg apt-transport-https flatpak gnome-software-plugin-flatpak timeshift linux-headers-amd64 -y

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo apt install nvidia-driver firmware-misc-nonfree -y

# Remove the lines with (: <<'END_COMMENT') and (END_COMMENT) to install the latest kernel, and ensure it's updated
# when the rest of the system updates. Replace them before and after the block without the () to install the stable
# kernel.

: <<'END_COMMENT'
sudo apt -t bookworm-backports install linux-image-amd64 linux-headers-amd64

sudo tee -a /etc/apt/preferences << EOF
Package: linux-image-*
Pin: release a=bookworm-backports
Pin-Priority: 500

Package: linux-headers-*
Pin: release a=bookworm-backports
Pin-Priority: 500
EOF
END_COMMENT


# Reboot
sudo reboot
## Reboot
sudo reboot
