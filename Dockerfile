FROM alpine:latest

RUN apk add --no-cache borgbackup

[...]

COPY entrypoint.sh /var/entrypoint.sh
RUN chmod +x /var/entrypoint.sh
ENTRYPOINT [ "/var/entrypoint.sh" ]
