#!/bin/bash

echo -e "\n reverse proxy with apache httpd \n"

PROXY_TO="$(kubectl get ingress | grep -o '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}')"

sudo bash -c "echo 'LoadModule proxy_module modules/mod_proxy.so <VirtualHost *:80> ProxyPass / http://$PROXY_TO/ ProxyPassReverse / http://$PROXY_TO/ ' >> /etc/httpd/conf/httpd.conf"

sudo system restart httpd
