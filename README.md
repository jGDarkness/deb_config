# deb_custom
This repo sets up my system the way I like, should I need a fresh installation and configuration. 

# WARNING
There is only basic error checking in place as of today. The scripts have not been tested in full yet, however, each individual command was used to configure the system and develop the script.

## Distribution
Debian 12 Bookworm

## Kernel
Default is for Bookworm Stable, however, there is a pair of lines that can be switched (commented / uncommented) in order
to switch to the Bookworm Backports kernel. 

### Pre-requisites

<ol>
<li>Debian Bookworm ISO (or CD image) written to a USB stick with a tool such as Balena Etcher, which is my personal preference.</li>
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