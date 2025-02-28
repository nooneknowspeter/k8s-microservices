#!/usr/bin/env bash

MINIKUBE_IP=$(minikube ip)

sudo /bin/su -c "echo '$MINIKUBE_IP   host.this' >> /etc/hosts"
