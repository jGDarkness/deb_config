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

sudo apt install wget gpg apt-transport-https flatpak gnome-software-plugin-flatpak timeshift linux-headers-amd64 -y

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo apt install nvidia-driver firmware-misc-nonfree -y

## Reboot
sudo reboot
