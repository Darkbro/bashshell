#/usr/bin
#Filename:proc_rol.sh
#set -x
function rotate
{
INTERVAL=1
RCOUNT="0"
while : 
do
	(( RCOUNT = RCOUNT + 1 ))
#        $RCOUNT=$(($RCOUNT+1))
	case $RCOUNT in 
		1) echo -e '-'"\b\c"
			sleep $INTERVAL
			;;
		2) echo -e '\\'"\b\c"
			sleep $INTERVAL
			;;
		3) echo -e "|\b\c"
			sleep $INTERVAL
			;;
		4) echo -e "/\b\c"
			sleep $INTERVAL
			;;
		*) RCOUNT="0"
			;;
	esac
done
}
rotate
