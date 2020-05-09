# borgbackup-docker-alpine
Minimal Alpine based Docker image for borgbackup

docker run \
   -t -d \
   --name borgbackup_test \
   -v /path/to/backup:/backup/test \
   -v /opt/backup/secrets/known_hosts:/root/.ssh/known_hosts \
   -v /opt/backup/secrets/id_rsa:/root/.ssh/id_rsa \
   -v /opt/backup/secrets/borg_repo_pw:/root/borg_repo_pw \
   -v $(pwd)/crontab:/root/crontab \
   -e BORG_REPO=ssh://user@host:port/./repo \
   -e BORG_RSH='ssh -i /root/.ssh/id_rsa' \
   -e PRIVATE_KEY_PATH=/var/run/backup_user_private_key \
   -e BORG_PASSPHRASE=/root/borg_repo_pw \
   -e LOCAL_FOLDER=/backup \
   -e BACKUP_INTERVAL=M \
   -e BACKUP_DB=N \
   -e MARIADB_HOST= \
   -e MARIADB_USER= \
   -e MARIADB_PW= \
   shiz0/borgbackup-docker-alpine:latest
