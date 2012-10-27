#!/bin/sh
#systemstat.sh 
#Mike.Xu
set -x
IP=172.18.0.230 
#touch /tmp/{cpu.txt,mem.txt,drive_sda1.txt,drive_sda2.txt,mnt_storage_0.txt,mnt_storage_pic.txt,connect_count.txt}
top -n 2 | grep "Cpu" >> /tmp/cpu.txt 
free -m | grep "Mem" >> /tmp/mem.txt 
df -k | grep "sda1" >> /tmp/drive_sda1.txt 
#df -k | grep sda2  >> /tmp/drive_sda2.txt 
df -k | grep "/mnt/storage_0" >> /tmp/mnt_storage_0.txt 
df -k | grep "/mnt/storage_pic"  >> /tmp/mnt_storage_pic.txt 
time=`date +%m"."%d" "%k":"%M` 
connect=`netstat -na | grep "172.17.62.64" | wc -l` 
echo "$time \$connect" >> /tmp/connect_count.txt

