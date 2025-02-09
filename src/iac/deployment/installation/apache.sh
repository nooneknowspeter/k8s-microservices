#!/bin/bash

echo -e "\n installing apache \n"

sudo apt install apache2 -y
sudo service apache2 start
