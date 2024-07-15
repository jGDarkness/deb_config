#! /bin/bash

# Baseline Dependencies

## Update, Upgrade, and Dist-upgrade
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade
sudo apt autoremove


# Make .dotfile directories
mkdir -p $HOME/.config

## Install dependencies for my favorite apps
sudo apt install wget gpg apt-transport-https flatpak gnome-software-plugin-flatpak timeshift


## Commands that require reboot:

### Rebooting at the end allows the GNOME plugin to integrate with GNOME on DE start.
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


## Reboot
sudo reboot
