#!/usr/bin/expect
set timeout 3
spawn su
expect "Password:"
send "Abcd1234"
expect "#"
interact
