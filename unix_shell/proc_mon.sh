#!/bin/bash
#Filename:proc_mon.sh
SCRIPT_NAME=`basename $0`

function usage
{

}

function exit_trap
{

}

trap 'exit_trap; exit 3' 1 2 3 15

if (( $# != 1 && $# != 2 ))
then
	usage
	exit 1
fi

case $# in
	1)	case $1 in
			'-v')	usage
				exit 1
					;;
			*)	PROCESS=$1
				;;
		esac
		;;
	2)	case $1 in
			'-v')	continue
				;;
		esac
		
		case $2 in 
			'-v')	usage
				exit 1
				;;
			*)	PROCESS=$2
				;;
		esac
		;;
	*)	usage
		exit 1
		;;
esac

ps -aux | grep "$PROCESS" | grep -v "grep $PROCESS" | grep -v "$SCRIP_NAME" >/dev/null
if (( $? != 0 ))
then
	echo -e "\n"
	ps aux | head -n 1
	ps aux | grep "$PROCESS" | grep -v "grep $PROCESS" | grep -v "$SCRIP_NAME"
fi

SLEEP_TIME="1"
RC="0"

echo
echo

while (( $RC == 0 ))
do
	ps aux | grep $PROCESS | grep -v "grep $PROCESS" | grep -v "$SCRIP_NAME" >/dev/null 2>&1
	if (( $? != 0 ))
	then
		echo 
		exit 0
	fi
	sleep $SLEEP_TIME
done 
