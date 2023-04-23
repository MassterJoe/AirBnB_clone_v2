#!/usr/bin/env bash
# A Bash script that sets up your web servers for the deployment of web_static


# install nginx if its not already installed
# if ! command -v nginx &> /dev/null
# then
apt-get update
apt-get install -y nginx
# fi


mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

touch /data/web_static/releases/test/index.html
echo "Holberton School" > /data/web_static/releases/test/index.html


ln -sf /data/web_static/releases/test/ /data/web_static/current


chown -R ubuntu /data/
chgrp -R ubuntu /data/


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
return 301 http://cuberule.com/;
}

error_page 404 /404.html;
location /404 {
root /var/www/html;
internal;
}

}" > /etc/nginx/sites-available/default

service nginx restart
