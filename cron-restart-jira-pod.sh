BAD_PODS=`kubectl get pods --no-headers -n homesite | grep "0/1" | awk {'print $1'}`
if [ -z "$BAD_PODS" ]; then
    log "No Pod in Not Ready state"
else
    for pod in $BAD_PODS
        do
            duration=`kubectl get pods --no-headers -n homesite $pod | grep "0/1" | awk -F' ' {'print $5'}`
            if [ `echo $duration | egrep "h|d"` ]; then
                log "Jira pod not ready since more than an hour. Deleting it."
                kubectl --context ${EKS_CLUSTER_NAME} delete pod $pod
            elif [ `echo $duration | awk -F'm' {'print $1'}` -gt 20 ]; then
                log "Jira pod not ready since more than 20 minutes. Deleting it."
                kubectl --context ${EKS_CLUSTER_NAME} delete pod $pod
            fi
        done
fi
fi

### BAD_PODS=`kubectl get pods --context ${EKS_CLUSTER_NAME} | grep "0/1" | awk {'print $1'}`
