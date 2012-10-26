#!/usr/bin/expect -f
#Filename:expect.sh
spawn ssh 172.18.0.233
expect "*password:"
send "Abcd1234\n"
interact
