#!/usr/bin/env bash

# start minikube
minikube start

# kubectl apply configurations
# apply deployments
kubectl apply -f ./../manifests/platforms-deploy.yaml
kubectl apply -f ./../manifests/commands-deploy.yaml

# node port to platforms service
kubectl apply -f ./../manifests/platforms-node-port-service.yaml

# forward port on host to node port
# node port maps to platform service cluster ip and port
# kubectl port-forward service/platform-node-port-service 8080:8080

# nginx ingress controller
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
minikube addons enable ingress

# delete ingress admission pod
kubectl delete --all-namespaces validatingwebhookconfiguration ingress-nginx-admission

# create ingress from configuration
kubectl create -f ./../manifests/ingress-service.yaml

# expose kubernetes cluser through load balancer and reverse proxy
minikube tunnel
