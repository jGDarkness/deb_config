#1/bin/bash

# Instructions obtained from https://linuxconfig.org/how-to-enable-disable-wayland-on-ubuntu-22-04-desktop
# and https://developer.nvidia.com/docs/drive/drive-os/6.0.8.1/public/drive-os-linux-sdk/common/topics/window_system_stub/Gnome-WaylandDesktopShellSupport136.html

sudo apt update
sudo apt install -y gdm3 mutter adwaita-icon-theme-full
sudo apt install -y --reinstall libdrm2 gnome-session

if ! id "gdm" &>/dev/null; then
    sudo useradd -m gdm
fisudo usermod -aG video gdm

sudo cp -f custom.conf /etc/gdm3/custom.conf
sudo ln -s /lib/systemd/system/gdm3.service /etc/systemd/system/multi-user.target.wants/gmd3.service
sudo systemctl daemon-reload

sudo reboot