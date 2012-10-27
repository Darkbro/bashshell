#!/bin/bash
#Filename:login_ssh.sh
set -x
#IP_TEST=`grep $1 /tmp/test.txt`
if [ -z $1 ];then
	echo "Sorry! you did not enter the hostname!"
	exit
else
#`grep $1 /tmp/test.txt > /tmp/login_ssh.txt`
IP_TEST=`grep $1 /tmp/test.txt`
fi
echo $IP_TEST > /tmp/login_ssh.txt
if [ -z /tmp/login_ssh.txt ];then
	echo "Sorry! The $1 is not exist"
	exit
else
	IP=`echo $IP_TEST | cut -d' ' -f 1`
	USER=`echo $IP_TEST | cut -d' ' -f 2`
	U_PASS=`echo $IP_TEST | cut -d' ' -f 3`
	R_PASS=`echo $IP_TEST | cut -d' ' -f 4`
#       cat /tmp/login_ssh.txt | read IP USER U_PASS R_PASS
fi
   login_root(){
	expect -c"spawn ssh root@$IP
		expect \"*yes/no\"
		send \"yes\r\"
		expect \"*password\"
		send \"$R_PASS\r\"
		interact"
	}
      login_user(){
        expect -c"spawn ssh $USER@$IP
                expect \"*yes/no\"
                send \"yes\r\"
                expect \"*password\"
                send \"$U_PASS\r\"
                interact"
        }

if [ $UID -eq 0 ];then
        login_root
else
        login_user
fi
exit
