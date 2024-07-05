#!/bin/bash

# Namespace to monitor
NAMESPACE="jira"

# Get all pods in the specified namespace with the status '0/1'
pods_to_delete=$(kubectl get pod jira-0 --no-headers -n jira | grep "0/1" | awk {'print $1'})

# Check if any pods match the criteria
if [ -n "$pods_to_delete" ]; then
  echo "Pods to delete: $pods_to_delete"
  
  # Loop through each pod and delete it
  for pod in $pods_to_delete; do
    echo "Deleting pod: $pod"
    kubectl delete pod $pod --namespace $NAMESPACE
  done
else
  echo "No pods to delete."
fi
