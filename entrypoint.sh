#!/bin/sh

if [ "$BACKUP_INTERVAL" = "5min" ]; then
	mkdir /etc/periodic/"$BACKUP_INTERVAL"
fi
if [ "$BACKUP_INTERVAL" = "custom" ]; then
	mkdir /etc/periodic/"$BACKUP_INTERVAL"
fi

ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup

export > /container.env

chown -R root:root /root

exec "$@"
