#!/bin/bash


SRC="/Source"
DEST="/Destination"
MAX_BACKUPS=7


# Get the latest backup to use incremental backup function
LATEST_BACKUP=$(/usr/bin/ls -1 --time=creation "$DEST" | /usr/bin/head -n 1)


# Create a timestamped dir for backup
BACKUP_NAME="backup-$(/usr/bin/date +'%Y-%m-%d_%H-%M-%S')"
BACKUP_PATH="$DEST/$BACKUP_NAME"


# --link-dest for incremental backups
if [ -n "$LATEST_BACKUP" ]; then
    /usr/bin/rsync -aAXv --delete --link-dest="$DEST/$LATEST_BACKUP" "$SRC/" "$BACKUP_PATH/"
else
    /usr/bin/rsync -aAXv --delete "$SRC/" "$BACKUP_PATH/"
fi


# Remove the oldest backup if more than MAX_BACKUPS value
cd "$DEST" || exit
BACKUP_COUNT=$(/usr/bin/ls -1t | /usr/bin/wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    OLDEST_BACKUP=$(/usr/bin/ls -1 --time=creation | /usr/bin/tail -n 1)
    /bin/rm -rf "$OLDEST_BACKUP"
fi
