#!/usr/bin/env bash
Jobs=`kubectl get job --no-headers -o custom-columns=":metadata.name"`
echo "$Jobs" | grep manual | while read -r Job; do
  kubectl delete job $Job
done