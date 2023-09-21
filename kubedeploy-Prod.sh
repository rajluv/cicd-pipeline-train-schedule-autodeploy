#!/bin/bash

# Define the path to your YAML file
#YAML_FILE="train-schedule-kube-canary.yml"

# Define the Kubernetes context
#CONTEXT="kubernetes-admin@kubernetes"

# Run kubectl apply with the specified context
#kubectl apply -f /var/lib/jenkins/workspace/Train-Schedule/train-schedule-kube-canary.yml
kubectl apply -f /var/lib/jenkins/workspace/Train-Schedule/train-schedule-kube.yml
