# Possible Security Software Installs

# Update DNS servers
sudo sed -i 's/^dns-nameservers.*/dns-nameservers 192.168.1.1 8.8.8.8 1.1.1.1/' /etc/network/interfaces
sudo systemctl restart networking
cat /etc/resolv.conf

# UFW (Uncomplicated Firewall)
sudo apt install -y ufw
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing

# RDP ports
sudo ufw allow 3389/tcp
sudo ufw allow 3389/udp

# SFTP/ssh ports
sudo ufw allow 22/tcp
sudo ufw allow 22/udp

# Minecraft server ports
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
sudo ufw allow 19132/tcp
sudo ufw allow 19132/udp
sudo ufw allow 8123/tcp
sudo ufw allow 8123/udp

# Apache webserver ports
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

sudo ufw reload
sudo ufw status verbose

# Install Apache web server
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl status apache2

# Create bookmark in Nautilus for Apache web server files main directory
mkdir -p ~/.config/gtk-3.0
echo "[Bookmarks]" > ~/.config/gtk-3.0/bookmarks
echo "file:///var/www/html" >> ~/.config/gtk-3.0/bookmarks

# Ensure the user has access to the Apache directory
sudo usermod -a -G www-data $USER
sudo chmod 775 /var/www/html

# Restart Nautilus to apply changes
nautilus -q

# Notify user about the created bookmark
echo "A bookmark to the 'Apache Web Server Files' has been created in File Manager."
sleep 2

# ClamAV
#wget https://www.clamav.net/downloads/production/clamav-1.3.1.linux.x86_64.deb
#sudo dpkg -i clamav-1.3.1.linux.x86_64.deb
#sudo rm -f clamav-1.3.1.linux.x86_64.deb

#fail2ban