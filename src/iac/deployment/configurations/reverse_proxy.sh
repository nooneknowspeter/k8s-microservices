#!/usr/bin/env bash

echo -e "\n reverse proxy with apache httpd \n"

PROXY_TO="localhost"

sudo bash -c "echo 'LoadModule proxy_module modules/mod_proxy.so <VirtualHost localhost> ProxyPass / http://$PROXY_TO/ ProxyPassReverse / http://$PROXY_TO/ ' >> /etc/httpd/conf/httpd.conf"

sudo systemctl restart httpd
