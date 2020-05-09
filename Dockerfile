FROM alpine:latest

RUN apk add --no-cache mariadb-backup
RUN apk add --no-cache borgbackup
RUN apk add --no-cache openssh-client

COPY backup.sh /root/backup.sh
RUN chmod 0700 /root/backup.sh

RUN mkdir /etc/periodic/5min
RUN mkdir /etc/periodic/custom

COPY crontab /root/crontab

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 0700 /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]

CMD ["sh", "-c", "crontab /root/crontab && crond -f"]

