#!/bin/bash
yum install httpd -y
systemctl enable --now httpd
rm -rf /var/www/*
find / -name "mail.conf" -exec rm -rf {} \;
find / -name "photo.conf" -exec rm -rf {} \;
mkdir -p /var/www/html
read -p "directory:-" directory1
mkdir  /var/www/$directory1
cd /var/www/$directory1
read -p "template link1:-" link1
wget $link1
unzip *.zip
rm -rf *.zip
mv */* /var/www/html
rm -rf /var/www/$directory1
read -p "Directory3:-" Dir3
read -p "Directory4:-" Dir4
read -p "listenport1:-" port1
cd /etc/httpd
read -p "Directory2.conf-" Directory2
echo "  listen $port1
        <VirtualHost *:$port1>
        servername mail.shubhamgupta.online
        documentroot /var/www/$Dir3
        </VirtualHost>
        <directory /var/www/$Dir3>
        require all granted
        options indexes followsymlinks
        directoryindex index.html
        </directory>" > $Directory2
cat /etc/httpd/$Directory2 >> /etc/httpd/conf.d/mail.conf
rm -rf /etc/httpd/$Directory2
mkdir -p /var/www/$Dir3/$Dir4
cd /var/www/$Dir3/$Dir4
read -p "template link 2:-" link2
wget $link2
unzip *.zip
rm -rf *.zip
mv -f */* /var/www/$Dir3
rm -rf /var/www/$Dir3/$Dir4semanage port -a -t http_port_t -p tcp $port1
read -p "Directory5:-" Dir5
read -p "Directory6:-" Dir6
read -p "listen_port:-" port2
cd /etc/httpd
read -p "Directory3.conf-" Directory3
echo "  listen $port2
        <VirtualHost *:$port2>
        servername photo.shubhamgupta.online
        documentroot /var/www/$Dir5
        </VirtualHost>
        <directory /var/www/$Dir5>
        require all granted
        options indexes followsymlinks
        directoryindex index.html
        </directory>" > $Directory3
cat /etc/httpd/$Directory3  >> /etc/httpd/conf.d/photo.conf
rm -rf /etc/httpd/$Directory3
mkdir -p /var/www/$Dir5/$Dir6
cd /var/www/$Dir5/$Dir6
read -p "template link3:-" link3
wget $link3
unzip *.zip
rm -rf *.zip
mv -f */* /var/www/$Dir5
rm -rf /var/www/$Dir5/$Dir6
semanage port -a -t http_port_t -p tcp $port2
systemctl restart httpd
