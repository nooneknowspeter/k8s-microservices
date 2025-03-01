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

# create default secret for database
kubectl create secret generic mssql-secret --from-literal=SA_PASSWORD="@Pa55word"

# kubectl apply database configuration
kubectl apply -f ./mssql-platform-deploy.yaml

# kubectl apply rabbitmq configuration
kubectl apply -f ./rabbitmq-deploy.yaml

# kubectl apply opentelemetry and lgtm configuration
kubectl apply -f ./open-lgtm-deploy.yaml

# nginx ingress controller
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
minikube addons enable ingress

# delete ingress admission pod
kubectl delete --all-namespaces validatingwebhookconfiguration ingress-nginx-admission

# create ingress from configuration
kubectl create -f ./ingress-service.yaml

cd ./../configurations/ || return

pwd
