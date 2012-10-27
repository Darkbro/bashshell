#!/bin/bash
#filename:ping.sh
for ip in 172.17.62.{1..255};
do 
 ping $ip -c 2 &> /dev/null;
`wait(5)`
  if [ $? -eq 0 ]
  then 
  echo $ip is alive
  fi
done
exit 0
