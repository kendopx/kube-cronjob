#!/bin/bash
AWS_ACCOUNT=$(aws sts get-caller-identity --query "Account" --output text)
aws ecr create-repository --repository-name homesite --image-tag-mutability MUTABLE > /dev/null 2>&1 
aws ecr describe-repositories | jq '.repositories[].repositoryName' | sed s/\"//g
docker build -f Dockerfile . -t $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com/homesite:latest
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com
docker push $AWS_ACCOUNT.dkr.ecr.us-east-2.amazonaws.com/homesite:latest
