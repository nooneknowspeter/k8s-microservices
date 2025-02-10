Content-Type: multipart/mixed
boundary="//"
MIME-Version: 1.0
--//
Content-Type: text/cloud-config
charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment
filename="cloud-config.txt"
#cloud-config
cloud_final_modules:
- [scripts-user, always]
--//
Content-Type: text/x-shellscript
charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment
filename="userdata.txt"

#!/usr/bin/env bash

ufw disable
iptables -L
iptables -F

# create working dir
mkdir app && cd app || return # return null in case cd fails

# update and upgrade system
sudo apt update && sudo apt upgrade -y
sudo apt-get update && sudo apt-get upgrade -y

# install ec2 instance connect
sudo apt-get install ec2-instance-connect

# install git
echo -e "\n installing git \n"
sudo apt-get install git -y

# clone project repository
git clone --recursive https://github.com/nooneknowspeter/k8s-microservices.git .

# cd into src folder
cd src/iac/deployment

# give all scripts executable permissions
chmod +x ./*.sh

# install docker
./installation/docker.sh

# install kubernetes
./installation/kubernetes.sh

# install minikube
./installation/minikube.sh

# install apache
./installation/apache.sh

# kubectl manifests
./configurations/k8s.sh

# reverse proxy minikube ip address
./configurations/httpd_reverse_proxy.sh
