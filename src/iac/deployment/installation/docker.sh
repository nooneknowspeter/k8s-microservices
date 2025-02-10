#!/usr/bin/env bash

echo -e "\n installing docker \n"

sudo yum install docker -y

sudo service docker start

sudo systemctl enable docker

sudo usermod -a -G docker ec2-user

sudo chmod 666 /var/run/docker.sock
