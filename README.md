# borgbackup-docker-alpine
Alpine based Docker image for borgbackup.\
Comes with mariabackup to include database server dumps.

Run with:
```
docker run \
  -t -d \
  --name youruniquename \
  --hostname youruniquename \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v youruniquename_dbtemp:/backup/mariadb \
  -v /backupsource1:/backup/backuptarget1 \
  -v /backupsource2:/backup/backuptarget2 \
  -v /backupsource3:/backup/backuptarget3 \
  -v /opt/backup/secrets/known_hosts:/root/.ssh/known_hosts \
  -v /opt/backup/secrets/id_rsa:/root/.ssh/id_rsa \
  -v /opt/backup/secrets/borg_repo_pw:/root/borg_repo_pw \
  -e BORG_REPO=ssh://user@host:port/./app_repo \
  -e BORG_RSH='ssh -i /root/.ssh/id_rsa' \
  -e BORG_PASSPHRASE=/root/borg_repo_pw \
  -e LOCAL_FOLDER=/backup \
  -e BACKUP_INTERVAL=hourly \
  -e BACKUP_DB=N \
  -e MARIADB_HOST= \
  -e MARIADB_USER= \
  -e MARIADB_PW= \
  shiz0/borgbackup-docker-alpine:latest
```
Edit the name to your liking, adjust the rest according to your setup

BACKUP_INTERVAL can be one of: 5min, 15min, hourly, daily, weekly, monthly or "custom".\
If "custom" is used, you will have to get the crontab, uncomment the last line and edit the schedule according to your needs.\
Add
```
-v /path/to/crontab:/root/crontab \
```
to the run command to overwrite the default file with yours.

Always check your logs, attempt restores etc. to be sure it's working but don't blame me if it does not. ;-)
