# deb_custom
This repo sets up my system the way I like, should I need a fresh installation and configuration. 

# WARNING
There is only basic error checking in place as of today. The scripts have not been tested in full yet, however, each 
individual command was used to configure the system and develop the script. The gui is currently a design only, and is
not complete.

## Distribution
Debian (bookworm / stable)

## Desktop Environment
GNOME 43.9 or newer, depending on how recently the bookworm ISO is used. I'm using one from May 2024.

## Kernel
### Bash Script
Default is for Bookworm Stable, however, there is block of code that can be commented / uncommented in order to set 
preference for the stable or backport kernel.

### Graphical User Interface - Design only as of now.
The initial gui design for the dependencies script has been created with Qt Designer. It is in the gui/ directory.
The gui will allow the user to decide whether or not to upgrade to the latest bookworm backport kernel with a checkbox.
At this point, all other dependencies are mandatorily installed.

### Pre-requisites

<ol>
<li>Debian Bookworm ISO (or CD image) written to a USB stick with a tool such as Balena Etcher, which is my personal 
preference.</li>
<li>Install the distribution onto the target machine or virtual machine.</li>
<li>I prefer to configure both a root account and a personal user account with the username: jeremy </li>
<li>Add the regular user account to the sudoers file.
'''sh
su root
sudo usermod -aG sudo jeremy
'''
If this method is not successful, a less preferred way is to add the user account to the sudoers file manually. The file is
located at /etc/sudoers.
</li>
</ol>

### Proceed with Configuration and Customization
<ol>
<li>Run
'''sh
sudo chmod +x 01_dependencies.sh
sudo /.01_dependencies.sh
'''
The system will automatically reboot after this script runs.
</li>
<li>Run
'''sh
sudo chmod +x 02_core_apps.sh
sudo /.02_core_apps.sh
'''
The process could require some user response interaction to complete, and the system will automatically reboot after this
script runs.
</li>
</ol>

### Work In Progress
The '03_security_apps.sh' script is currently in progress... do not use yet.