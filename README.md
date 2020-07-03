Current state: Basic tests successful. Should be okay \
ToDo: Complete Readme.


# borgbackup-docker-alpine
Alpine based Docker image for borgbackup.\
Can optionally run mariabackup container to include database server dumps.

Run with:
```
docker run \
-v /var/run/docker.sock:/var/run/docker.sock \
-v <youruniquename>_dbtemp:/backup/mariadb \
-v /backupsource1:/backup/backuptarget1 \
-v /backupsource2:/backup/backuptarget2 \
-v /backupsource3:/backup/backuptarget3 \
-v /opt/backup/secrets/known_hosts:/root/.ssh/known_hosts \
-v /opt/backup/secrets/id_rsa:/root/.ssh/id_rsa \
-v /opt/backup/secrets/borg_repo_pw:/root/borg_repo_pw \
-v /opt/backup/secrets/mariadb_pw:/root/mariadb_pw \
--name youruniquename \
-h youruniquename \
-e BORG_REPO=ssh://host:port/./<reponame> \
-e BORG_RSH=ssh -i /root/.ssh/id_rsa \
-e BORG_PASSPHRASE=/root/borg_repo_pw \
-e BACKUP_INTERVAL=5min \
-e MARIADB_CONTAINER=your_mariadb_container_to_backup \
-e MARIADB_USER=root \
-e MARIADB_PW=secretadmin \
-e BORG_INIT_CMD=--encryption=repokey \
-e BORG_CREATE_CMD=--stats ::{now:%Y-%m-%d_%H-%M-%S} /backup \
-e BORG_PRUNE_CMD=-n --list --force --keep-last 5 \
shiz0/borgbackup-docker-alpine:latest ```

```
Edit the name to your liking, adjust the rest according to your requirements.

If optional mount 
```
-v /opt/backup/secrets/mariadb_pw:/root/mariadb_pw
```
is used, the file contents will be read inside the container and used as password when connecting to the database. \
This is to avoid giving the password in cleartext in the environment section. \
If you are already using a variable -or docker secrets- for that, you can omit this and set the password in the environment below.

Database backup is optional. If not all of MARIADB_CONTAINER, MARIADB_USER, MARIADB_PW are set, database backup function will be skipped.

BACKUP_INTERVAL can be one of: 5min, 15min, hourly, daily, weekly, monthly or "custom".\
If omitted, backup function will be skipped and you could run other borg commands instead. \
If "custom" is used, you will have to get the crontab, uncomment the last line and edit the schedule according to your needs. Add
```
-v /path/to/crontab:/root/crontab \
```
to the run command to overwrite the default file with yours.

For possible values/usage of BORG_REPO, BORG_RSH, BORG_PASSPHRASE, the BORG_*_CMD variables, as well as other borg commands, please consult the borg documentation at \
https://borgbackup.readthedocs.io/

And, last but not least: \
**Always check your logs, attempt restores etc. to be sure it's working!**
