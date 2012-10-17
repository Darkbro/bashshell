#!/bin/bash
#filename:backupall.sh
i=0
find / -name conf > file
if [ -d /tmp/conf ]
then 
echo "/tmp/conf already exist!"
else
  mkdir -p /tmp/conf
  echo "/tmp/conf is created!"
fi
while read LINE
do
DIRS=$LINE
BACKUP="/tmp/conf/backup${i}.tar.gz"
tar -zvcf $BACKUP $DIRS
i=$((i+1))
done<file
echo "--------------------------------------"
echo "Back up already finished!"
echo "--------------------------------------"
