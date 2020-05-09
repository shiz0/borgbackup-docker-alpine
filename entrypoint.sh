#!/bin/sh

if [ "$BACKUP_INTERVAL" = "M" ]; then
	ln -s /root/run_backup.sh /etc/periodic/15min/
fi
if [ "$BACKUP_INTERVAL" = "H" ]; then
        ln -s /root/run_backup.sh /etc/periodic/hourly/
fi
if [ "$BACKUP_INTERVAL" = "D" ]; then
        ln -s /root/run_backup.sh /etc/periodic/daily/
fi
if [ "$BACKUP_INTERVAL" = "W" ]; then
        ln -s /root/run_backup.sh /etc/periodic/weekly/
fi
if [ "$BACKUP_INTERVAL" = "M" ]; then
        ln -s /root/run_backup.sh /etc/periodic/monthly/
fi
if [ "$BACKUP_INTERVAL" = "C" ]; then
	mkdir /etc/periodic/custom; \
        ln -s /root/run_backup.sh /etc/periodic/custom/
fi

#declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID' > /container.env

export > /container.env

exec "$@"

#/bin/sh -c 'crontab /etc/crontabs/root && crond -d 0 -f'
