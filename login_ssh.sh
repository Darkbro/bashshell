#!/bin/bash
#Filename:login_ssh.sh
while read LINE 
cat >ssh.exp <<\EOF
#!/usr/bin/expect 
set timeout 60 

expect {
    spawn ssh 

expect eof
}
