#!/bin/bash
sudo su
yum update -y
yum install -y httpd
cd /var/www/html
wget https://github.com/aeezsaul/mole-site1/raw/main/mole.zip
unzip mole.zip
cp -r /var/www/html/mole-main/* /var/www/html
rm -rf mole.zip mole-main
systemctl enable httpd
systemctl start httpd