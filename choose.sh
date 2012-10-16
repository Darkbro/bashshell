#!/bin/bash
#filename:choose.sh
echo "Please choose : (1-3,or ^c)"
echo "1 vi"
echo "2 X-window"
echo "3 print-file"
echo "Ctrl+c quit"

read xyz
if [ $xyz = 1 ]
then
  vi 
  exit 1
elif [ $xyz = 2 ]
then 
  startx
  exit 1
elif [ $xyz = 3 ]
then
  echo "Please enter filename:"
  read filename
  lp $filename &
  exit 1
else
  echo "-----------------------------------"
  echo "Choose $xyz is not exist"
  echo "-----------------------------------"
  /bin/sh choose.sh
fi
