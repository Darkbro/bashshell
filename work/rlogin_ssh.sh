#!/bin/bash
#Filename:login_ssh.sh
set -x
if [ -z $1 ];then
	echo "Sorry!you must enter the hostname or ip!"
	exit
fi
rlogin_root(){
        expect -c"spawn ssh root@$IP
                  expect \"*yes/no)?\"
                  send \"yes\"
                  expect \"*password:\"
                  send \"$R_PASS\n\"
                  interact"
        }
rlogin_user(){
        expect -c"spawn ssh $USER@$IP
                  expect \"*yes/no)\"
                  send \"yes\r\"
                  expect \"*password:\"
                  send \"$U_PASS\r\"
                  interact"
        }
while read IP USER U_PASS R_PASS
	do
	if [ $1 == $IP ];then
		if [ $UID -eq 0 ];then
			rlogin_root
#expect -c "spawn ssh root@$IP"
#expect -c "expect \"*password:\""
#expect -c "send \"$R_PASS\""
#expect -c "interact"

		sleep 2
		else
			rlogin_user
		fi
	else
		echo "$1 is not exist!"
	fi

done</tmp/test.txt





















#if [ -z $1 ];then
#        echo "Sorry! you did not enter the hostname!"
#        exit
#else
#`grep $1 /tmp/test.txt > /tmp/rlogin_ssh.txt`
#fi
#if [ -z /tmp/rlogin_ssh.txt ];then
#        echo "Sorry! The $1 is not exist"
#        exit
#else
#	
#fi
#   login_root(){
#        expect -c"spawn ssh root@$IP
#                expect \"*yes/no\"
#                send \"yes\r\"
#                expect \"*password\"
#                send \"$R_PASS\r\"
#                interact"
#        }
#      login_user(){
#        expect -c"spawn ssh $USER@$IP
#                expect \"*yes/no\"
#                send \"yes\r\"
#                expect \"*password\"
#                send \"$U_PASS\r\"
#                interact"
#        }
#
#if [ $UID -eq 0 ];then
#        login_root
#else
#        login_user
#fi
#`rm -rf /tmp/rlogin_ssh.txt `
#exit
