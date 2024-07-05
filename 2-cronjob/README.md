

```sh
### Build docker image 
docker build -t swilliamx/cron-restart-jira-pod:latest .
docker push swilliamx/cron-restart-jira-pod:latest

### View cron 
kubectl get cronjob -n jira 
kubectl delete cronjob cron-restart-jira-pod -n jira 
kubectl get cronjob -n jira 
kubectl logs hello-world-27982521-bgb46
kubectl get jobs --watch


### Delete ECR repo 
aws ecr describe-repositories | jq '.repositories[].repositoryName' | tr -d '"'
aws ecr delete-repository --repository-name cron-restart-jira-pod --force

### For loop 
for i in `kubectl get pod jira-0 --no-headers -n jira | grep "0/1" | awk {'print $1'}`; do kubectl delete pod $i -n jira; done 
for i in `kubectl get pod confluence-0 --no-headers -n jira | grep "0/1" | awk {'print $1'}`; do kubectl delete pod $i -n jira; done 
