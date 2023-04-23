#!/usr/bin/env bash
# A Bash script that sets up your web servers for the deployment of web_static


# install nginx if its not already installed
if ! command -v nginx &> /dev/null
then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# create directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

#create a fake html file
sudo touch /data/web_static/releases/test/index.html
echo "Holberton School" > /data/web_static/releases/test/index.html

#create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# give owenership to user and group
sudo chown -R ubuntu:ubuntu /data/

# update the nginx configuration to serve /data/web_static/current/ to hbnb_static

printf %s "server {
listen 80 default_server;
listen [::]:80 default_server;
add_header X-Served-By $HOSTNAME;
root /var/www/html;
index index.html index.htm;

location /hbnb_static {
alias /data/web_static/current;
index index.html index.htm;
}

location /redirect_me {
return 301 http://www.google.com/;
}

error_page 404 /404.html;
location /404 {
root /var/www/html;
internal;
}

}" > /etc/nginx/sites-available/default

sudo service nginx restart
