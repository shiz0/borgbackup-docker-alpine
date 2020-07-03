#!/bin/sh

if [ -f /root/mariadb_pw ]; then
	MARIADB_PW=$(cat /root/mariadb_pw)
fi

if [ -n "$BACKUP_INTERVAL" ]; then
if [ "$BACKUP_INTERVAL" = "5min" ] || [ "$BACKUP_INTERVAL" = "custom" ]; then
	mkdir /etc/periodic/"$BACKUP_INTERVAL"
fi
ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi

export > /container.env
exec "$@"
