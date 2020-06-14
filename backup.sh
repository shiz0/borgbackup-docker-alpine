#!/bin/sh

# backup database if set

# get database conatiner's network
DBNET=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{println .NetworkID}}{{end}}' "$MARIADB_CONTAINER" | head -1)

# get mariadb container's database version
DBVERSION=$(docker exec -i "$MARIADB_CONTAINER" mysqld --version | pcregrep -o -e '\d+(\.\d+){2,}' | head -1)

# get own dbtemp volume
TEMPVOL=$(docker volume ls -qf name="$HOSTNAME"_dbtemp)

if [ -n "$MARIADB_CONTAINER" ]  && [ -n "$MARIADB_USER" ] && [ -n "$MARIADB_PW" ]; then
        docker run --name mariabackup_temp --rm \
        --network "$DBNET" \
        --volumes-from "$MARIADB_CONTAINER" \
        -v "$TEMPVOL":/backup \
        mariadb:"$DBVERSION" \
	/bin/sh -c \
	"mariabackup --host "$MARIADB_CONTAINER" --user "$MARIADB_USER" --password "$MARIADB_PW" --backup --version-check --rsync --target-dir=/backup ; \
	mariabackup --prepare --target-dir=/backup ; \
	chown -R mysql:mysql /backup"
fi


# initialize repo
borg init --encryption=repokey

# backup
borg create --stats ::$(date +%Y-%m-%d_%H-%M-%S) /backup
