#!/bin/bash
k3d cluster create dev --api-port 6550 -p "8081:80@loadbalancer" --servers 1 --agents 2