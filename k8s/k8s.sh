#!/usr/bin/bash

# start minikube
minikube start

# kubectl apply configurations
# apply deployments
kubectl apply -f ./platforms-deploy.yaml
kubectl apply -f ./commands-deploy.yaml

# node port to platforms service
kubectl apply -f ./platforms-node-port-service.yaml

# forward port on host to node port
# node port maps to platform service cluster ip and port
kubectl port-forward service/platform-node-port-service 8080:8080

# nginx ingress controller
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
minikube addons enable ingress

# delete ingress admission pod
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

# create ingress from configuration
kubectl create -f ./ingress-service.yaml

# expose kubernetes cluser through load balancer and reverse proxy
minikube tunnel
