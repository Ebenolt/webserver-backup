#!/bin/bash


if [[ $EUID -ne 0 ]]; then
        printf "\e[33m /!\ This script must be run with sudo /!\ \e[0m\n"
        exit 1
fi

clear

username=$(who am i | awk '{print $1}')
working_dir=$(pwd)

read -p " -Which folders to backup (paths with spaces eg: /path/to/folder1 /path/to/folder/2 ) : " to_backup
read -p " -Destination: " dest
read -p " -MariaDB User (make sure he get access to DBs): " mysql_user
read -p " -MariaDB Pass: " mysql_pass
read -p ' -Databases to backup (DBs under quotes with spaces eg: "db1" "db2 "db3"): ' databases

printf "Configuring script: "
sed -i "s/#tobackup#/$to_backup/g" webbackup.sh
sed -i "s/#dest#/$dest/g" webbackup.sh
sed -i "s/#mysql_user#/$mysql_user/g" webbackup.sh
sed -i "s/#mysql_pass#/$mysql_pass/g" webbackup.sh
sed -i "s/#databases#/${databases}/g" webbackup.sh

printf "\e[32mOK\e[0m\n"


printf "Configuring cron: "
echo "#Web_backup" >> "/var/spool/cron/crontabs/root"
echo "0 0 * * * bash $working_dir/webbackup.sh" >> "/var/spool/cron/crontabs/root"
printf "\e[32mOK\e[0m\n\n"
