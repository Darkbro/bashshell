#!/bin/bash
set -x
while read LINE
do
ippass=$LINE
ip=`echo $ippass | cut -d' ' -f 1`
password=`echo $ippass | cut -d' ' -f 3`
#done<ippass.txt
ssh_login(){   
expect -c"spawn ssh root@$ip   
expect \"*password:\"
send \"$password\n\"
interact"
}
ssh_login
#mkdir -p text 

sleep 2
done<ippass.txt
exit
#sed -i 's/allowed.*/allowed_host=172.18.0.230/'
