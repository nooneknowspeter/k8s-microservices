#!/usr/bin/env bash

cd ./../manifests/ || return

pwd

# start minikube
minikube start

# kubectl apply configurations
# apply deployments
kubectl apply -f ./platforms-deploy.yaml
kubectl apply -f ./commands-deploy.yaml

# node port to platforms service
kubectl apply -f ./platforms-node-port-service.yaml

# persistent volume claim
kubectl apply -f ./local-persistent-volume-claim.yaml

kubectl create secret generic mssql-secret --from-literal=SA_PASSWORD="@Pa55word"

kubectl apply -f ./mssql-platform-deploy.yaml

# nginx ingress controller
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
minikube addons enable ingress

# delete ingress admission pod
kubectl delete --all-namespaces validatingwebhookconfiguration ingress-nginx-admission

# create ingress from configuration
kubectl create -f ./ingress-service.yaml

# forward ports to services in detached state
kubectl port-forward service/platform-node-port-service 8080:8080 &
kubectl port-forward service/mssql-loadbalancer 1433:1433 &

cd ./../configurations/ || return

pwd
