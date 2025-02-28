#!/usr/bin/env bash

# forward ports to services in detached state for development purposes

# node ports
kubectl port-forward service/platform-node-port-service 8080:8080 &

# databases
kubectl port-forward service/mssql-loadbalancer 1433:1433 &

# message queues
kubectl port-forward service/rabbitmq-loadbalancer 15672:15672 &
kubectl port-forward service/rabbitmq-loadbalancer 5672:5672 &

# monitoring
kubectl port-forward service/lgtm-loadbalancer 3000:3000 &
kubectl port-forward service/lgtm-loadbalancer 4317:4317 &
kubectl port-forward service/lgtm-loadbalancer 4318:4318 &
