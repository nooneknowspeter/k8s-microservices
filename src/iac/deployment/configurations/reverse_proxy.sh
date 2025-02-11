#!/usr/bin/env bash

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

cp ./nginx.conf /etc/nginx/

sudo systemctl reload nginx
