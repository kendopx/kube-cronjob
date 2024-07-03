# Use an appropriate base image
FROM alpine:latest

# Install kubectl
RUN apk add --no-cache curl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Copy the script into the container
COPY delete_failed_pods.sh /usr/local/bin/delete_failed_pods.sh

# Make the script executable
RUN chmod +x /usr/local/bin/delete_failed_pods.sh

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/delete_failed_pods.sh"]
