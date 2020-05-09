#!/bin/sh

if [ "$BACKUP_INTERVAL" = "5min" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi
if [ "$BACKUP_INTERVAL" = "15min" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi
if [ "$BACKUP_INTERVAL" = "hourly" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi
if [ "$BACKUP_INTERVAL" = "daily" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi
if [ "$BACKUP_INTERVAL" = "weekly" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi
if [ "$BACKUP_INTERVAL" = "monthly" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi
if [ "$BACKUP_INTERVAL" = "custom" ]; then
        ln -s /root/backup.sh /etc/periodic/"$BACKUP_INTERVAL"/backup
fi

export > /container.env

chown -R root:root /root

exec "$@"
