#!/bin/bash

function mne_error_handler()
{
    # Aufruf mit: trap 'mne_error_handler $BASH_COMMAND $LINENO $?' ERR

	if [ "$mne_error_ignore" = "1" ]; then
		return;
	fi

	if [ "$mne_error_need" = "" ]; then
	    cmd=`echo $1 | cut "-d " -f 1`
        if [ "$cmd" = "fgrep" ]; then
		 return;
		fi
	fi
    
    echo "error in: $0" 1>&2
    echo "     cmd: $1" 1>&2
    echo "    line: $2" 1>&2
    echo "  status: $3" 1>&2
    exit 1
}

trap 'mne_error_handler "$BASH_COMMAND" $LINENO $?' ERR
exit_status=0

export LANG=C

DBUSER=mneerpsystem
DB=erpdb

IMPL=mneerp
DATAROOT=`pwd`/data

SYSVERSION=default
fgrep 12.04 /etc/issue 2>&1 > /dev/null
if [ "$?" = "0" ]; then
    SYSVERSION=12_04
 fi

fgrep 14.04 /etc/issue 2>&1 > /dev/null
if [ "$?" = "0" ]; then
    SYSVERSION=14_04
fi
 
if [ -f "exec/local/system/config/$SYSVERSION/config.sh" ]; then
  . exec/local/system/config/$SYSVERSION/config.sh
fi

if [ -f "exec/system/config/$SYSVERSION/config.sh" ]; then
  . exec/system/config/$SYSVERSION/config.sh
fi