#!/bin/bash
#filename:doexec.sh
i=1
while [ "$i" -eq 1 ]
do
RESPONSE=
echo "-------------------------------"
echo "Please choose:"
echo "Input -- stop -- kill myfiles"
echo
echo
echo
  
read RESPONSE
case $RESPONSE in

  start) ./myfiles;;
  stop) killall myfiles;;
  status) ps -aux | grep myfiles;;
  quit) i=0
  echo "Quit,Thanks"
;;
esac
done
