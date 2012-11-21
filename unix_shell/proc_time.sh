#/usr/bin
#Filename:proc_time
set -x
while true
do 
	sleep 2
	echo -e  ".\c"
#	sleep 2
done &
#done

#dots 10 &

BG_PID=$!

/usr.local/bin/mybackup.sh
#sleep 20
kill $BG_PID
echo
