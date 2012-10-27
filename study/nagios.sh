#!/bin/sh
#Filename:nagios.sh
#`ssh 172.18.0.233`<<Abcd1234
#Abcd1234
set -x
while read LINE 
do 
ippass=$LINE 
ip=`echo $ippass | cut -d' ' -f 1`
password=`echo $ippass | cut -d' ' -f 3`
echo $ip
echo $password
done<ippass.txt


#sed -i 's/allowed.*/allowed_host=172.18.0.230/'
