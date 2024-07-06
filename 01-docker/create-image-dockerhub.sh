#!/bin/bash

docker build -t swilliamx/cron-restart-jira-pod:latest .
docker push swilliamx/cron-restart-jira-pod:latest
