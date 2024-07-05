# Use the official Alpine image as a base
FROM alpine:latest

# Copy the bash script into the container
COPY cron-restart-jira-pod.sh /usr/local/bin/cron-restart-jira-pod.sh

# Make the script executable
RUN chmod +x /usr/local/bin/cron-restart-jira-pod.sh

# Specify the entrypoint command to run the script
ENTRYPOINT ["/usr/local/bin/cron-restart-jira-pod.sh"]
