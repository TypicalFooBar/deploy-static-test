#!/usr/bin/env bash
# Configures server for static deploy
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install nginx

rm -rf /data

mkdir /data
mkdir /data/web_static
mkdir /data/web_static/releases
mkdir /data/web_static/releases/test
mkdir /data/web_static/shared

touch /data/web_static/releases/test/index.html
echo "Howdy, pardner!" >> /data/web_static/releases/test/index.html

ln -sf /data/web_static/releases/test /data/web_static/current

chown -R ubuntu:ubuntu /data

stringToReplace="^\tlocation / {"
newString="\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n\n\tlocation / {"
sudo sed -i "s@${stringToReplace}@${newString}@" /etc/nginx/sites-available/default

service nginx restart
