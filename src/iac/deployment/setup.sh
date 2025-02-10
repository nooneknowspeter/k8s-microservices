#!/usr/bin/env bash

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
