#!/bin/bash

# Where to backup to.
dest="#dest#"

# What to backup.
backup_files="$dest/backup.sql /etc/nginx #tobackup#"


mysqldump -u "#mysql_user#" -p#mysql_pass# --databases #databases# > $dest/backup.sql

# Create archive filename.
day=$(date -I)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
clear
echo "$(date) Backing up $backup_files to $dest/$archive_file"
echo

# Backup the files using tar.
tar cvzf $dest/$archive_file $backup_files

# Print end status message.
echo "$(date) Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
