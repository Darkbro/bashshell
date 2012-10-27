#!/bin/bash
#filename:checksys.sh
df>dfmesg
pr -e dfmesg | awk '{stuff}'
sed '/1K-/d' dfmesg >dfmesg_noheader
ps -aux | more > cpumesg
pr -e cpumesg | awk '{stuff}'
sed '/USER/d' cpumesg > cpumesg_noheader
while read LINE1
do
DISK=$LINE1
echo $DISK > df_item
DF=`awk 'BEGIN { FS=" "; } { print $4; }' df_item`
echo $DF>df_field
DD=`awk 'BEGIN { FS="%"; } { print $1; }' df_field`
DINTER=$(($DD+0))

if [ $? -eq 0 ]
then
  if [ $DINTER -gt 50 ]
  then
  echo $DISK>>df_report
  else
  echo "This system have enough HD.">>df_report
  fi
  else 
  echo "Check system HD Error"
  fi
done<dfmesg_noheader
