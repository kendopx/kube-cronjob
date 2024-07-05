#!/bin/bash

for i in `kubectl get pod --no-headers -n jira | grep "1/1" | grep nginx | awk {'print $1'}`; do kubectl delete pods $i -n jira; done 
