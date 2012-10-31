#!/bin/bash
#Filename:login_ssh.sh
#set -x
if [ -z $1 ];then
	echo "--------------------------------------------"
	echo "+ Sorry!    you must enter the ip!         +"
	echo "--------------------------------------------"
	exit
fi

IP_PASS=`grep $1' ' /tmp/test.txt`
IP=`echo $IP_PASS | cut -d' ' -f 1`
U_PASS=`echo $IP_PASS | cut -d' ' -f 3`
R_PASS=`echo $IP_PASS | cut -d' ' -f 4`

rlogin_root(){
        expect -c "spawn ssh root@$IP
		expect \"*yes/no)?\"
		send \"yes\r\"
                expect \"*password:\"
                send \"$R_PASS\r\"
                interact"
        }

rlogin_user(){
        expect -c"spawn ssh $USER@$IP
                  expect \"*password:\"
                  send \"$U_PASS\r\"
                  interact"
        }

if [ $1 == "$IP" ];then
	if [ $UID -eq 0 ];then
		rlogin_root
		sleep 2
		exit
	else
		rlogin_user
	fi
else
	echo "------------------------"
	echo "+ $1 is not exist!     +"
	echo "------------------------"
fi

exit









