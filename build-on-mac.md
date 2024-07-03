```sh
FROM nginx
RUN apt-get update && apt-get upgrade -y \
RUN rm -rf /usr/share/nginx/html
COPY html /usr/share/nginx/
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]


docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm64/v8,linux/386,linux/mips64le,linux/ppc64le,linux/aarch64 -t swilliamx/webserver:v1 --push .

docker run -d -p 80:80 --restart=always --name webserver swilliamx/webserver:v1 
docker run -d -p 80:80 --restart=always --name webserver1 swilliamx/webserver:v1 
```


################################################################


# Creating a container image for use on Amazon ECS

**Objectives**

- Create an application image with the path of Dockerfile.

- Create the tag for the image.

- Run tests against the created image.

- Login on AWS ECR with the username and password.

- Create ECR Image Repository. 

- Push the image to a remote registry.

Pre-requisite

1. Docker 

2. aws cli 

3. aws configure 

Let's get started

### Mac 
brew cask install docker



```sh
Run "aws configure" to configure your aws creds on your devbox 
For the below command works correctly; replace the region value with whatever you set your default to in "cat ~/.aws/configure"

# First things first, Find your AWS Account ID with the AWS CLI
AWS_ACCOUNT=$(aws sts get-caller-identity --query "Account" --output text)

# Login to the AWS ECR through CLI
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com

# Create a Repository in ECR
aws ecr create-repository --repository-name homesite --image-tag-mutability IMMUTABLE > /dev/null 2>&1 

# Get aws ecr repositories names with aws cli, parsing results with jq and stripping double quotes with sed or tr
aws ecr describe-repositories | jq '.repositories[].repositoryName' | sed s/\"//g

# docker build -t homesite .
# docker run -itd -p 80:80 homesite

# Build docker image 
cd /tmp/docker
ccc

docker build -t $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com/homesite:v1 .
docker build -t homesite .
docker images

# Let’s verify it using the docker image ls command.
docker image ls

# Run docker 
docker run -itd -p 80:80  $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com/homesite:v1 
docker ps

# To test 
# Find the IP address of your instance and place it on the web broswer 

# Push the image to the repository
docker push $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com/homesite:v1


### To list repositories 
aws ecr describe-repositories | jq '.repositories[].repositoryName' | tr -d '"'

### Clean up
aws ecr delete-repository --repository-name homesite --force
```
