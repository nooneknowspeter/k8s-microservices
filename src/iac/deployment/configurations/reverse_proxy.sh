#!/usr/bin/env bash

echo -e "\n reverse proxy with apache httpd \n"

PROXY_TO="host.this"

sudo /bin/su -c "echo '
ProxyPass / http://$PROXY_TO/ 
ProxyPassReverse / http://$PROXY_TO/
' >> /etc/httpd/conf/httpd.conf"

sudo systemctl restart httpd
