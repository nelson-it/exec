#!/bin/bash

function mne_error_handler()
{
    # Aufruf mit: trap 'mne_error_handler $BASH_COMMAND $LINENO $?' ERR

    if [ "`type -t script_error_handler`" = "function" ]; then
         script_error_handler $1 $2 $3
    fi

	if [ "$mne_error_ignore" = "1" ]; then
		return;
	fi

    if [ "$mne_error_need" = "" ]; then
        cmd=`echo $1 | cut "-d " -f 1`
        if [ "$cmd" = "grep" ] || [ "$cmd" = "fgrep" ] || [ "$cmd" = "egrep" ]; then
            return;
        fi
    fi
  
    echo "error in: $0" 1>&2
    echo "     cmd: $1" 1>&2
    echo "    line: $2" 1>&2
    echo "  status: $3" 1>&2
    if [ "$noexit" = "1" ]; then
        noexit=0
        return;
    fi
    exit 1
}

trap 'mne_error_handler "$BASH_COMMAND" $LINENO $?' ERR
exit_status=0

function mne_checksys()
{
	for i in "${sysok[@]}"
	do
		if [ "$SYSVERSION" = "$i" ]; then
			return;
		fi
	done
	
	echo "system not supported" 1>&2
	exit 2;
}

export LANG=C

bs='\\'

DBUSER=
DB=
DATAROOT=
TEMLDIR=exec/system/templates

while [ $# -gt 0 ] ; do
  case $1 in
    -project) project=$2; shift 2;;
       -user) daemonuser=$2; shift 2;;
     -locale) deamonlocale=$2; shift 2;;
     -va*)    p=${1//\./_}; eval "${p:1}=\"$2\"";  shift 2 ;;
     *)       shift 1 ;;
  esac
done

. $project/exec/system/config.sh

UNAME=`uname`
SYSVERSION=default

if [ "$UNAME" = "Linux" ]; then
  fgrep 12.04 /etc/issue 2>&1 > /dev/null
  if [ "$?" = "0" ]; then
      SYSVERSION=12_04
   fi

  fgrep 14.04 /etc/issue 2>&1 > /dev/null
  if [ "$?" = "0" ]; then
    SYSVERSION=14_04
  fi

  fgrep 15.04 /etc/issue 2>&1 > /dev/null
  if [ "$?" = "0" ]; then
    SYSVERSION=15_04
  fi
fi

if [ "$UNAME" = "Darwin" ]; then
    sw_vers -productVersion | fgrep 10.8 > /dev/null
    if [ "$?" = "0" ]; then
      SYSVERSION=mac_10_8
    fi
    sw_vers -productVersion | fgrep 10.11 > /dev/null
    if [ "$?" = "0" ]; then
      SYSVERSION=mac_10_11
    fi
fi

  . exec/system/config/config.sh

if [ -f "exec/local/system/config/config.sh" ]; then
  . exec/local/system/config/config.sh
fi

if [ -f "exec/system/config/$SYSVERSION/config.sh" ]; then
  . exec/system/config/$SYSVERSION/config.sh
fi

if [ -f "exec/local/system/config/$SYSVERSION/config.sh" ]; then
  . exec/local/system/config/$SYSVERSION/config.sh
fi

