#!/usr/bin/env bash

# install docker
./installation/docker.sh

# install kubernetes
./installation/kubernetes.sh

# install minikube
./installation/minikube.sh

# install apache
./installation/apache.sh

# reverse proxy minikube ip address
./configurations/reverse_proxy.sh

# kubectl manifests
./configurations/k8s.sh
