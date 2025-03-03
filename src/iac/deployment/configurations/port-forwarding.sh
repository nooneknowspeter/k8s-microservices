#!/usr/bin/env bash

# forward ports to services in detached state for development purposes

# node ports
echo -e "\n --> forwarding node port"
kubectl port-forward service/platform-node-port-service 8080:8080 &

# databases
echo -e "\n --> forwarding sql server load balancer"
kubectl port-forward service/mssql-loadbalancer 1433:1433 &

# message queues
echo -e "\n --> forwarding rabbitmq load balancer"
kubectl port-forward service/rabbitmq-loadbalancer 15672:15672 & # management
kubectl port-forward service/rabbitmq-loadbalancer 5672:5672 &

# monitoring
echo -e "\n --> forwarding open telemetry and lgtm load balancer"
kubectl port-forward service/lgtm-loadbalancer 4320:3000 & # grafana
kubectl port-forward service/lgtm-loadbalancer 4317:4317 & # otel gRPC
kubectl port-forward service/lgtm-loadbalancer 4318:4318 & # otel http

# frontend
echo -e "\n --> forwarding frontend application"
kubectl port-forward service/frontend-loadbalancer 3600:3000 &
