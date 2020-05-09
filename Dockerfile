FROM alpine:latest

RUN apk add --no-cache mariadb-backup
RUN apk add --no-cache borgbackup
RUN apk add --no-cache openssh-client

COPY backup.sh /root/backup.sh
RUN chmod +x /root/backup.sh
COPY run_backup.sh /root/run_backup.sh
RUN chmod +x /root/run_backup.sh

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]

CMD ["sh", "-c", "crontab /root/crontab && crond -f"]

