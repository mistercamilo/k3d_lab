#!/bin/bash
k3d cluster create dev --api-port 6550 -p "8081:80@loadbalancer" --servers 1 --agents 2 --server-arg "--no-deploy=traefik"

kubectl create deployment alpaca-prod --image=gcr.io/kuar-demo/kuard-amd64:blue --replicas=2 
kubectl create deployment alpaca-test --image=gcr.io/kuar-demo/kuard-amd64:green --replicas=1 

kubectl create deployment bandicoot-prod --image=gcr.io/kuar-demo/kuard-amd64:green --replicas=2
kubectl create deployment bandicoot-staging --image=gcr.io/kuar-demo/kuard-amd64:blue --replicas=1


kubectl label deployment alpaca-prod "ver=1,app=alpaca,env=prod"
kubectl label deployment alpaca-test "ver=2,app=alpaca,env=test"
kubectl label deployment bandicoot-prod "ver=2,app=bandicoot,env=prod"
kubectl label deployment bandicoot-staging "ver=2,app=bandicoot,env=staging"