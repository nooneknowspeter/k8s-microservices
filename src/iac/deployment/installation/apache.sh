#!/usr/bin/env bash

echo -e "\n installing apache \n"

sudo yum install -y httpd

sudo systemctl start httpd

sudo systemctl enable httpd
