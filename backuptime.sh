#!/bin/bash
#filename:backuptime.sh
DIRNAME=`ls /root | grep etcbak`
echo $DIRNAME
	if [ -z $DIRNAME ]
   then
    mkdir -p /root/etcbak
        fi
   cd /root/etcbak
YY=`date +%y`
MM=`date +%m`
DD=`date +%d`
BACKETC=$YY$MM$DD_etc.tar.gz
tar -zcvf $BACKETC /etc
echo "File backup finished!"
