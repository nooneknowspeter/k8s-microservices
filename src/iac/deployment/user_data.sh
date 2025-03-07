#!/usr/bin/env bash

ufw disable
iptables -L
iptables -F

# create working dir
mkdir app && cd app || return # return null in case cd fails

pwd

# update and upgrade system
sudo yum update -y

# install ec2 instance connect
sudo yum install ec2-instance-connect -y

# install and start tmux
sudo yum install tmux -y

# install git
echo -e "\n installing git \n"
sudo yum install git -y

# clone project repository
git clone --recursive https://github.com/nooneknowspeter/k8s-microservices.git .

# cd into src folder
cd src/iac/deployment || return

pwd

# give all scripts executable permissions
chmod +x ./*.sh
chmod +x ./installation/*.sh
chmod +x ./configurations/*.sh

# setup and configure server
./setup.sh
