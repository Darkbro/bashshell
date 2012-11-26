#!/bin/bash
#Filename:proc_watch.sh
LOGFILE="/tmp/proc_status.log"
[[ ! -s $LOGFILE ]] && touch $LOGFILE

PROCESS="$1"
SCRIPT_NAME=`basename $0`
TTY=`tty`

function usage
{

}

function trap_exit
{

}

function mon_proc_end
{
	END_RC="0"
	until (( $END_RC != 0 ))
	do
		
	done
}

function mon_proc_start
{

}

######################################
##### start of main###################
######################################


