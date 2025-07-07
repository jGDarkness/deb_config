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

sudo cp ~/Downloads/deb_config/images/jgd_debian_avatar.png /home/$USER/.face
sudo cp ~/Downloads/deb_config/images/jgd_debian_avatar.png /home/$USER/.face.icon
sudo mkdir -p /usr/share/backgrounds
sudo cp ~/Downloads/deb_config/images/jgd_debian_wallpaper.png /usr/share/backgrounds/

# This script should be run after 01_dependencies.sh
# Check if dependencies from 01_dependencies.sh are installed.
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is not installed. Please run 01_dependencies.sh first."
        exit 1
    fi
}

# Check for required dependencies
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
echo "* Chrome                         * Flathub                            *"
echo "* Clipboard                      * Extension Manager/Flathub          *"
echo "* Color Picker                   * apt                                *"
echo "* Curl                           * apt                                *"
echo "* Dash to Dock Extension         * Extension Manager/Flathub          *"
echo "* dconf Editor                   * Flathub                            *"
echo "* Dropbox                        * Dropboxstatic.com                  *"
echo "* Discord                        * Flathub                            *"
echo "* Filezilla                      * apt                                *"
echo "* Git                            * apt                                *"
echo "* GIMP                           * apt                                *"
echo "* Just Perfection Extension      * Extension Manager/Flathub          *"
echo "* Kdenlive                       * Flathub                            *"
echo "* Moneydance                     * InfiniteKind.com                   *"
echo "* Nerd Fonts - Jet Brains Mono   * github.com/ryanoasis/nerd-fonts    *"
echo "* Obsidian                       * Flathub                            *"
echo "* PeaZip                         * Flathub                            *"
echo "* Proton GE                      * GitHub                             *"
echo "* Steam                          * Flathub                            *"
echo "* Sushi (NautilusPreviewer)      * Flathub                            *"
echo "* Tiling Shell                   * Extension Manager/Flathub          *"
echo "* Thunderbird                    * Flathub                            *"
echo "* VLC                            * apt                                *"
echo "* VSCode                         * Packages.Microsoft.com             *"
echo "* Zoom                           * Flathub                            *"
echo "***********************************************************************"
echo ""
echo "***********************************************************************"
echo "* App Name to Remove             * Source Repository                  *"
echo "***********************************************************************"
echo "* Firefox ESR                    * apt                                *"
echo "***********************************************************************"
echo ""
echo ""
echo "Installation will begin in:"
echo "Type 's' to begin immediately, or wait for the countdown."
for i in {45..1}
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
   sleep (3)
fi

sudo flatpak install flathub com.google.Chrome -y 
sudo apt install color-picker -y
sudo apt install curl -y
sudo flatpak install flathub ca.desrt.dconf-editor -y
sudo flatpak install flathub com.discordapp.Discord -y

# Dropbox
wget https://linux.dropboxstatic.com/packages/debian/dropbox_2024.04.17_amd64.deb
sudo dpkg -i dropbox_2024.04.17_amd64.deb
sudo rm -f dropbox_2024.04.17_amd64.deb

sudo apt install filezilla -y
sudo apt install git -y
`git config --global user.name "jGDarkness"
git config --global user.email "jeremy.g.davenport@gmail.com"`
sudo apt install gimp -y
sudo flatpak install flathub org.kde.kdenlive -y

# Moneydance
wget https://infinitekind.com/stabledl/current/moneydance_linux_amd64.deb
sudo dpkg -i moneydance_linux_amd64.deb
sudo rm -i moneydance_linux_amd64.deb -y

sudo flatpak install flathub md.obsidian.Obsidian -y
sudo flatpak install flathub io.github.peazip.PeaZip -y

sudo curl -sS https://starship.rs/install.sh | sudo sh
sudo flatpak install flathub org.mozilla.Thunderbird -y
sudo apt install vlc vlc-plugin-fluidsynth vlc-plugin-jack vlc-plugin-pipewire vlc-plugin-svg libdvdcss2 -y
sudo dpkg-reconfigure libdvd-pkg

# Steam and Proton GE
sudo flatpak install flathub com.valvesoftware.Steam -y
sudo flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE -y
sudo apt install steam-devices

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install code
sudo rm -f ./code_*_amd64.deb
code --install-extension ms-vscode.cpptools
code --install-extension sidthesloth.html5-boilerplate
code --install-extension ecmel.vscode-html-css
code --install-extension george-alisson.html-preview-vscode
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-jupyter-powertoys
code --install-extension ms-toolsai.vscode-jupyter-slideshow
code --install-exension ms-python.vscode-pylance
code --install-extension ms-python.python
code --install-extension ms-python.pythondebug
code --install-extension platformio.platformio-ide
code --install-extension MarlinFirmware.auto-build
code --install-extension drewxs.tokyo-night-dark

# Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip 
sudo unzip JetBrainsMono.zip -d/usr/share/fonts
sudo rm -f JetBrainsMono.zip

sudo flatpak install flathub org.gnome.NautilusPreviewer -y
sudo apt remove firefox-esr -y

ssh-keygen -t ed25519 -C "jeremy.g.davenport@gmail.com"
ssh-add ~/.ssh/id_ed25519

sudo flatpak install flathub us.zoom.Zoom -y

sudo apt autoremove
sleep 2
clear

echo "The following configuration step may require user intervention and input to complete."
read -p "Enter 'yes' to continue: " user_input
while [ "$user_input" != "yes" ]; do
    read -p "Please enter 'yes' to continue: " user_input
done

# Update font cache 
sudo fc-cache -f -v
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMonoNerdFont-Regular 11'
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

echo "Configuration has been successfully completed."
echo "A system snapshot will now be captured using Timeshift."
sleep 2

# Timeshift backup
sudo timeshift --rsync 
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
for i in {30..1}; do
    echo "Rebooting in $i seconds..."
    sleep 1
done
echo "Rebooting now!"
sudo reboot