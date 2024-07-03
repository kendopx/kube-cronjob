```sh

kubectl create -f jenkins-service.yaml
kubectl get service

ubectl describe pod jenkins-5fdbf5d7c5-dj2rq
kubectl describe pod | grep jenkins
kubectl cluster-info | grep master


### Docker - Mac 
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm64/v8,linux/386,linux/mips64le,linux/ppc64le,linux/aarch64 -t swilliamx/jenkins:v1 --push .
docker run -d -p 80:80 --restart=always --name jenkins swilliamx/jenkins:v1 