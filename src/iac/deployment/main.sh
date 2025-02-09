#!/usr/bin/env bash

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

# give all scripts executable permissions
chmod +x ./*glob*

# install docker
./deployment/installation/docker.sh

# install kubernetes
./deployment/installation/kubernetes.sh

# install minikube
./deployment/installation/minikube.sh

# install apache
./deployment/installation/apache.sh

# kubectl manifests
./deployment/configurations/k8s.sh

# reverse proxy minikube ip address
./deployment/configurations/httpd_reverse_proxy.sh
