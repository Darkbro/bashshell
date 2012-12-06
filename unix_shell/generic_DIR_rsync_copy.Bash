#!/bin/bash
set -x
MACHINE_LIST="fred"
DIR_LIST_FILE="rsync_directory_list.lst"
WORK_DIR=/usr/local/bin
LOGFILE="generic_DIR_rsync_copy.log"
THIS_HOST=$(hostname)
OS=$(uname)

elapsed_time ()
{

SEC=$1
(( SEC < 60 )) && echo -e "[Elapsed time : $SEC seconds!]\c"

(( SEC >= 60 && SEC < 3600 )) && echo -e "[Elapsed time : $(( SEC / 60 )) min $(( SEC % 60 ))]\c"

(( SEC >= 3600 )) && echo -e "[Elapsed time : $(( SEC / 3600 )) hr $((  (SEC % 3600) / 60 )) min $(( (SEC % 3600) % 60 )) seconds]\c"

}

verify_copy ()
{

MYLOGFILE=${WORK_DIR}/verify_rsync_copy.log
>$MYLOGFILE
ERROR=0

{

for M in $MACHINE_LIST
do
	for DS in $(cat $DIR_LIST_FILE)
	do
		LS_FILES=$(find $DS -type f)
		for FL in $LS_FILES
		do
			LOC_FS=$(ls -l $FL | awk '{print $5}' 2>&1)
			REM_FS=$(ssh $M ls -l $FL | awk '{print $5}' 2>&1)
			echo "Checking File: $FL"
			echo -e "Local $THIS_HOST size:\t$LOC_FS"
			echo -e "Rmote $M size:\t$REM_FS"
			if [ "$LOC_FS" -ne "$REM_FS"]
			then
				echo "ERROR: File size mismatch between $THIS_HOST and $M"
				echo "File is: $FL"
				ERROR=1
			fi
		done
	done
done
if (( ERROR != 0))
then
	echo -e "\n\nRSYNC ERROR: $THIS_HOST Rsync copy failed...file size mismatch...\n\n" | tee -a $MYLOGFILE
	echo -e "\nERROR: Rsync copy failed"
	echo -e "\n\nCheck log file: $MYLOGFILE\n\n"
	echo -e "\n...Exiting...\n"
	sleep 2
	exit 3
else
	echo -e "\nSUCCESS: Rsync copy completed successfully!\n"
	echo -e "\nALL file sizes match...\n"
fi
} | tee -a $MYLOGFILE
}

############################
## Begin Of Main
############################

{

cp -f $LOGFILE ${LOGFILE}.yesterday 2>/dev/null
>$LOGFILE
echo -e "\nStarting a bunch of rsync sessions...$(date)\n"
TOTAL=0

for M in $MACHINE_LIST
do
	for DS in $(cat $DIR_LIST_FILE)
	do
		if ! $(echo "$DS" | grep -q '/$')
		then
			DS="${DS}/"
		fi
		time rsync -avz ${DS} ${M}:${DS} 2>&1 &
	done
done

sleep 10

EGREP_LIST=

while read DS
do
	if [ -z $EGREP_LIST ]
	then
		EGREP_LIST="$DS"
	else
		EGREP_LIST="|$DS"
	fi
done < $DIR_LIST_FILE

REM_SESSIONS=$(ps -x | grep "rsync -avz" | egrep "$EGREP_LIST" | grep -v grep | awk '{print $1}' | wc -l)

if (( REM_SESSIONS > 0))
then
	echo -e "\n$REM_SESSIONS of $TOTAL rsync copy sessions require further updating..."
	echo -e "\nProcessing rsync copies from $THIS_HOST to both $MACHINE_LIST machines"
	echo -e "\nPlease be patient, this process may a very long time...\n"
	echo -e "Rsync is running [Start time: $(date)]\c"
else
	echo -e "\nALL files appear to be in sync...verifying file size... Please wait...\n"
fi

SECONDS=10

MIN_COUNTER=0

until (( REM_SESSIONS == 0 ))
do
	sleep 60
	echo -e ".\c"
	REM_SESSIONS=$(ps x | grep "rsync -avz" | egrep "$EGREP_LIST" | grep -v grep | awk '{print $1}' | wc -l)
	if (( REM_SESSIONS < TOTAL ))
	then
		(( MIN_COUNTER = MIN_COUNTER + 1 ))
		if (( MIN_COUNTER >= $(( TOTAL / 2 )) ))
		then
		 	MIN_COUNTER=0	
			echo -e "\n$REM_SESSIONS of $TOTAL rsync sessions remaining $(elapsed_time $SECONDS)\c"
			if (( REM_SESSIONS <= $(( TOTAL / 4 )) ))
			then
				echo -e "\nRemaining rsync sessions include:\n"
				ps x | grep "rsync -avz" | egrep "$EGREP_LIST" | grep -v grep
				echo
			fi
		fi
	fi
done

echo -e "\n...Local rsync processing completed on ${THIS_HOST}...$(date)"
echo -e "\n...Checking remote target machine(s): ${MACHINE_LIST}..."

for M in $MACHINE_LIST
do
	for DS in $(cat $DIR_LIST_FILE)
	do
		RPID=$(ssh $M ps x | grep rsync | grep $DS | grep -v grep | awk '{print $1}')
		until [ -z "$RPID" ]
		do
			echo "rsync is processing ${MP} on ${M}... sleeping one minute..."
			sleep 60
			RPID=$(ssh $M ps x | grep rsync | grep $DS | grep -v grep | awk '{print $1}')
		done
	done
done

echo -e "\n...Remote copy completed $(date)"

verify_copy

echo -e "\nRsync copy completed $(date)"
echo -e "\nElapsed time: $(elapsed_time $SECONDS)\n"
} 2>&1 | tee -a $LOGFILE

############################
##### End Of Script
############################
