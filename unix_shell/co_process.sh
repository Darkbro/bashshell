#!/bin/bash
#Filename:co_process.sh
set -x
function trap_exit
{
	BREAK_OUT='Y'
	echo $BREAK_OUT
}

function proc_watch
{
	while :
	do 
		i=1
		if [ i -gt 0 ] 
		then
			i=$(($i+1))
		fi
		read $BREAK_OUT
		if [[ $BREAK_OUT = 'Y' ]]
		then 
			return 0
		fi
	done
}

trap 'trap_exit; exit 2' 1 2 3 15
TOTAL_SECONDS=3
BREAK_OUT='N'
proc_watch |&
PW_PID=$$
echo $PW_PID
until (( TOTAL_SECONDS == 0 ))
do
	(( TOTAL_SECONDS = TOTAL_SECONDS - 1))
		echo $TOTAL_SECONDS
		sleep 1
done

BREAK_OUT='Y'
echo $BREAK_OUT
kill -9 $PW_PID
exit 0
