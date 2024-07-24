#!/bin/bash

# Check to see if the script is being run with sudo permissions.
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with: sudo ./install.sh" 2>&1
    exit 1 
fi

sudo xdotool getactivewindow windowsize 100% 100%

sudo cp images/jgd_debian_avatar.png /home/$USER/.face
sudo cp images/jgd_debian_avatar.png /home/$USER/.face.icon
sudo mkdir -p /usr/share/backgrounds
sudo cp images/jgd_debian_wallpaper.png /usr/share/backgrounds/
sudo dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/share/backgrounds/jgd_debian_wallpaper.png'"

# This script should be run after 01_dependencies.sh
# Check if dependencies from 01_dependencies.sh are installed.
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is not installed. Please run 01_dependencies.sh first."
        exit 1
    fi
}

# Check for required dependencies
check_dependency "imagemagick"
check_dependency "xdotool"
check_dependency "wget"
check_dependency "gpg"
check_dependency "flatpak"
check_dependency "apt-transport-https"
check_dependency "gnome-software-plugin-flatpak"
check_dependency "timeshift"

# Check if flatpak remote is added
if ! flatpak remotes | grep -q "flathub"; then
    echo "Error: Flathub remote is not added. Please run 01_dependencies.sh first."
    exit 1
fi

# If all checks pass, continue with the script
echo "All dependencies are installed. Proceeding with core apps installation..."
sleep 1
clear

# Notify the user of the pending installation/removal of the listed apps.
echo "The following core applications will be installed and/or customized: "
echo ""
echo "***********************************************************************"
echo "* App Name to Install            * Source Repository                  *"
echo "***********************************************************************"
echo "* Blender                        * apt                                *"
echo "* Chrome                         * Flathub                            *"
echo "* Clipboard                      * Github                     ON HOLD *"
echo "* Color Picker                   * apt                                *"
echo "* Curl                           * apt                                *"
echo "* Dash to Dock Extension         * Github                     ON HOLD *"
echo "* dconf Editor                   * Flathub                            *"
echo "* Dropbox                        * Dropboxstatic.com                  *"
echo "* Discord                        * Flathub                            *"
echo "* Filezilla                      * apt                                *"
echo "* Git                            * apt                                *"
echo "* GIMP                           * apt                                *"
echo "* Just Perfection Extension      * Github                     ON HOLD *"
echo "* Kdenlive                       * Flathub                            *"
echo "* Moneydance                     * InfiniteKind.com                   *"
echo "* Nerd Fonts - Jet Brains Mono   * github.com/ryanoasis/nerd-fonts    *"
echo "* Obsidian                       * Flathub                            *"
echo "* PeaZip                         * Flathub                            *"
echo "* Remmina                        * Flathub                            *"
echo "* Starship                       * Starship.rs                        *"
echo "* Sushi (NautilusPreviewer)      * Flathub                            *"
echo "* Tiling Shell                    * Github                    ON HOLD *"
echo "* Thunderbird                    * Flathub                            *"
echo "* VLC                            * apt                                *"
echo "* VSCode                         * Packages.Microsoft.com             *"
echo "* WPS Office                     * WPSCDN.com                         *"
echo "* WPS Office - Missing Fonts     * GitHub Various                     *"
echo "***********************************************************************"
echo ""
echo "***********************************************************************"
echo "* App Name to Remove             * Source Repository                  *"
echo "***********************************************************************"
echo "* Firefox ESR                    * apt                                *"
echo "***********************************************************************"
echo ()
echo ()
echo "Installation will begin in:"
echo "Type 's' to begin immediately, or wait for the countdown."
for i in {20..1}
do
   echo -ne "\r$i "
   read -t 1 -n 1 input
   if [[ "$input" == "s" ]]; then
       echo -e "\nStarting installation..."
       break
   fi
done

if [[ $i -eq 0 ]]; then
   echo -e "\rStarting installation..."
fi

sudo apt install blender -y

sudo flatpak install flathub com.google.Chrome -y 

sudo apt install color-picker -y

sudo apt install curl -y

sudo flatpak install flathub ca.desrt.dconf-editor -y

sudo flatpak install flathub com.discordapp.Discord -y

# Dropbox
wget https://linux.dropboxstatic.com/packages/debian/dropbox_2024.04.17_amd64.deb
sudo dpkg -i dropbox_2024.04.17_amd64.deb
sudo rm -f dropbox_2024.04.17_amd64.deb -y

sudo apt install filezilla -y

sudo apt install git -y

sudo apt install gimp -y

sudo flatpak install flathub org.kde.kdenlive -y

# Moneydance
wget https://infinitekind.com/stabledl/current/moneydance_linux_amd64.deb
sudo dpkg -i moneydance_linux_amd64.deb
sudo rm -i moneydance_linux_amd64.deb -y

sudo flatpak install flathub md.obsidian.Obsidian -y
    # Note that any obsidian plugins you already have installed will be synced on vault open. Restart Obsidian after they all load, and all works.

sudo flatpak install flathub io.github.peazip.PeaZip -y

sudo flatpak install flathub org.remmina.Remmina -y

sudo curl -sS https://starship.rs/install.sh | sudo sh -y

sudo flatpak install flathub org.mozilla.Thunderbird -y

sudo apt install vlc -y

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install code
sudo rm -f ./code_*_amd64.deb
code --install-extension sourcegraph.cody-ai
code --install-exension ms-python.vscode-pylance
code --install-extension ms-python.python
code --install-extension ms-python.pythondebug
code --install-extension ms.vscode.cpptools
code --install-extension platformio.platformio-ide
code --install-extension MarlinFirmware.auto-build

# WPS Office
wget https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11720/wps-office_11.1.0.11720.XA_amd64.deb
cd /home/jeremy/Downloads
sudo dpkg -i wps-office_11.1.0.11720.XA_amd64.deb
sudo rm -f wps-office_11.1.0.11720.XA_amd64.deb
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

# Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip 
sudo unzip JetBrainsMono.zip -d/usr/share/fonts
sudo rm -f JetBrainsMono.zip

sudo flatpak install flathub org.gnome.NautilusPreviewer -y

sudo apt remove firefox-esr -y

# Post config cleanup
sudo apt autoremove
sleep 2

clear

echo "The following configuration step may require user intervention and input to complete."
read -p "Enter 'yes' to continue: " user_input
while [ "$user_input" != "yes" ]; do
    read -p "Please enter 'yes' to continue: " user_input
done

# Generate SSH key
ssh-keygen -t ed25519 -C "jeremy.g.davenport@gmail.com"

echo "Configuration has been successfully completed."
echo "A system snapshot will now be captured using Timeshift."
sleep 2

# Update font cache 
sudo fc-cache -f -v
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMonoNerdFont-Regular 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMonoNerdFont-ExtraLight 11'
dconf reset -f /org/gnome/terminal/legacy/profiles:/
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
echo "Updating terminal font for profile with ID: $PROFILE_ID (default)"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/font "'JetBrainsMono Nerd Font Mono 11'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/use-system-font false

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo 'eval "$(starship init bash)"' >> ~/.bashrc
sudo mkdir -p ~/.config
sudo cp starship.toml ~/.config/starship.toml

# Timeshift backup
sudo timeshift --create --comments "Fresh install, customized" --tags D
sleep 2
clear

echo "A system snapshot has been captured with the new configuration."
sleep 2

echo "The system needs to reboot now to finalize the updated configurations of all apps."
echo ""
sleep 2
echo "Don't forget to open Extension Manager after rebooting the machine to enable and configure installed extensions."
echo ""
read -p "Enter 'yes' to continue with the reboot: " reboot_input
while true; do
    read -p "Enter 'yes' to continue with the reboot: " reboot_input
    if [ "$reboot_input" = "yes" ]; then
        break
    fi
done

# Post config reboot
for i in {10..1}; do
    echo "Rebooting in $i seconds..."
    sleep 1
done
echo "Rebooting now!"
sudo reboot