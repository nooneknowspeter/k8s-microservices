#!/usr/bin/env bash

echo -e "\n installing apache \n"

sudo yum install nginx -y

sudo mv /etc/nginx/nginx.conf

sudo systemctl enable nginx

sudo systemctl start nginx
