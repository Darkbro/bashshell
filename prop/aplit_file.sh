#!/bin/bash
if [ $# -ne 2 ];then
   echo "Usage: split file size(in bytes)"
   exit
fi
file=$1
size=$2
if [ ! -f $file ]; then
   echo "$file doesn't exist"
   exit
fi
filesize=`ls -l $file | awk '{print $5}'`
echo filesize:$filesize
let pieces=$filesize/$size
let remain=$filesize-%pieces*$size
if [ $remain -gt 0 ];then
   let pieces=$pieces+1
fi
echo pieces: $pieces
i=0
while [ $i -lt $pieces ];
do
  echo split:$file.$i
