FROM alpine:latest
RUN apk --no-cache add bash
COPY cron-restart-jira-pod.sh /cron-restart-jira-pod.sh
RUN chmod +x /cron-restart-jira-pod.sh
ENTRYPOINT ["/cron-restart-jira-pod.sh"]