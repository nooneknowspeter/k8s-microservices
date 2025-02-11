#!/usr/bin/env bash

# cd into installation folder
cd ./installation/ || return

# install docker
./docker.sh

# install kubernetes
./kubernetes.sh

# install minikube
./minikube.sh

# install apache
./apache.sh

# cd into configurations folder
cd ./../configurations || return

# minikube init and kubectl manifests
./k8s.sh

# reverse proxy minikube ip address
./reverse_proxy.sh

# edit hosts files
./hosts.sh

# expose kubernetes cluser through load balancer and reverse proxy
minikube tunnel
