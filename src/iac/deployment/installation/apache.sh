#!/usr/bin/env bash

echo -e "\n installing apache \n"

sudo yum install httpd -y

sudo systemctl start httpd

sudo systemctl enable httpd
