#! /bin/bash


# Install my favorite core apps.
# This script should be run after 01_dependencies.sh



## Timeshift
sudo apt install timeshift -y


## Git
sudo apt install git -y
ssh-keygen -t ed25519 -C "jeremy.g.davenport@gmail.com"



## VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install code
sudo rm -f ./code_*_amd64.deb


## Chrome
sudo flatpak install flathub com.google.Chrome -y 


## Thunderbird
sudo flatpak install flathub org.mozilla.Thunderbird -y


## Dropbox
wget https://linux.dropboxstatic.com/packages/debian/dropbox_2024.04.17_amd64.deb
sudo dpkg -i dropbox_2024.04.17_amd64.deb
sudo rm -f dropbox_2024.04.17_amd64.deb -y


## Kdenlive
sudo flatpak install flathub org.kde.kdenlive -y


## Moneydance
wget https://infinitekind.com/stabledl/current/moneydance_linux_amd64.deb
sudo dpkg -i moneydance_linux_amd64.deb
sudo rm -i moneydance_linux_amd64.deb -y


## PeaZip
sudo flatpak install flathub io.github.peazip.PeaZip -y


## GNOME Extension Manager
sudo flatpak install flathub com.mattjakeman.ExtensionManager -y


## Blender
sudo apt install blender -y


## GIMP
sudo apt install gimp -y


## WPS Office
wget https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11720/wps-office_11.1.0.11720.XA_amd64.deb
cd /home/jeremy/Downloads
sudo dpkg -i wps-office_11.1.0.11720.XA_amd64.deb
sudo rm -f wps-office_11.1.0.11720.XA_amd64.deb

### Install missing fonts for WPS Office
wget https://raw.githubusercontent.com/justrajdeep/fonts/master/Wingdings.ttf
wget https://raw.githubusercontent.com/justrajdeep/fonts/master/Wingdings%202.ttf
wget https://raw.githubusercontent.com/justrajdeep/fonts/master/Wingdings%203.ttf
wget https://raw.githubusercontent.com/justrajdeep/fonts/master/Webdings.ttf
wget https://raw.githubusercontent.com/justrajdeep/fonts/master/Symbol.ttf
wget https://raw.githubusercontent.com/dv-anomaly/ttf-wps-fonts/master/mtextra.ttf
sudo cp /./home/jeremy/Downloads/*.ttf /usr/share/fonts/wps-office
cd /home/jeremy/Downloads
sudo rm -f *.ttf
cd ~


## Custom Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip 
sudo unzip JetBrainsMono.zip -d/usr/share/fonts
sudo rm -f JetBrainsMono.zip



## Remove Firefox
sudo apt remove firefox-esr -y


### Post config cleanup
sudo apt autoremove


## Timeshift backup
sudo timeshift --create --comments "Fresh install, customized" --tags D


### Post config reboot
sudo reboot