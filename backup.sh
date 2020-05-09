#!/bin/sh

# backup database if set
if [ "$BACKUP_DB" = "Y" ]; then
	mkdir /backup/mariadb ; \
	mariabackup --host "$MARIADB_HOST" --user "$MARIADB_USER" --password "$MARIADB_PW" --backup --rsync --target-dir=/backup/mariadb ; \
        mariabackup --prepare --target-dir=/backup/mariadb ; \
fi

# initialize repo
borg init --encryption=repokey

# backup
borg create --stats ::$(date +%Y-%M-%d_%H:%M:%S) /backup 
