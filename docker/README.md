```sh
chmod +x delete_failed_pods.sh

docker build -t your-docker-registry/delete-failed-pods:latest .
docker push your-docker-registry/delete-failed-pods:latest
kubectl apply -f cronjob.yaml
