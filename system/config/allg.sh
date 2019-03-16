#!/bin/bash

if [ "$ALLGREADED" = "" ]; then
        
    ALLGREADED=1
    . $(dirname $BASH_SOURCE)/functions.sh
    
    trap 'mne_error_handler "${BASH_SOURCE[*]}" $LINENO $?' ERR
    trap cleanup EXIT

    exit_status=0

    export LANG=C
    umask 0022
    
    bs='\\'
    
    DBUSER=
    DB=
    DATAROOT=
    
    actdate=$(date +%d.%m.%Y_%H:%M:%S)
    acttime=$(date +%s)

    stdout=3
    stderr=4
    logfile=5
    log=/var/log/mne/system.log
    
    exec 3>&1
    exec 4>&2
    
    exec 2> >( tee -ia ${log} 1>&2 )
    exec 1> >( tee -ia ${log} )
    exec 5> >( tee -ia ${log} 1>/dev/null )
    
    echo `date` ===================================================================== 1>&$logfile
    echo $0 1>&$logfile
    
    phkomma="'"'\"'"'"'\"'"'"
    prog='/'"'"'/ { gsub(/'"'"'/, "'$phkomma'") } { print$0 }'
    
    while [ $# -gt 0 ] ; do
      case $1 in
        -project) project=$2; shift 2;;
           -user) daemonuser=$2; shift 2;;
           -group) daemongroup=$2; shift 2;;
         -locale) deamonlocale=$2; shift 2;;
            -va*) p=${1//\./_};
                  v=`echo "$2" | awk "$prog"`;
                  eval "${p:1}='$v'";
                  i="${p:1}ignore"
                  if [ "${!i}" = "" ] && [[ ! "${p:1}" == *"passwd"* ]] && [[ ! "${p:1}" == *"password"* ]]; then
                    echo "${p:1}=$v" 1>&$logfile
                  else
                    echo "${p:1}=********" 1>&$logfile
                  fi
                  shift 2 ;;
         *)       shift 1 ;;
      esac
    done
    
    . $project/exec/system/config.sh
    
    if [ "$(uname)" = "Linux" ]; then
      . /etc/lsb-release
    fi

    if [ "$(uname)" = "Darwin" ]; then
        sw_vers -productVersion | fgrep 10.8 1>&$logfile
        if [ "$?" = "0" ]; then
          DISTRIB_CODENAME="Mountain Lion"
          DISTRIB_RELEASE=10_8
        fi
    
        sw_vers -productVersion | fgrep 10.11 1>&$logfile
        if [ "$?" = "0" ]; then
          DISTRIB_CODENAME="El Capitan"
          DISTRIB_RELEASE=10_11
        fi

        sw_vers -productVersion | fgrep 10.13 1>&$logfile
        if [ "$?" = "0" ]; then
          DISTRIB_CODENAME="High Sierra"
          DISTRIB_RELEASE=10_13
        fi

        DISTRIB_ID="MacOS"
        DISTRIB_DESCRIPTION="$DISTRIB_ID $DISTRIB_RELEASE $DISTRIB_RELEASE"
    fi
    
      mne_error_ignore=1
      . exec/system/config/config.sh >/dev/null 2>&1
      mne_error_ignore=
    
    if [ -f "exec/local/system/config/config.sh" ]; then
      . exec/local/system/config/config.sh
    fi
    
    if [ -f "exec/system/config/${DISTRIB_ID,,}/config.sh" ]; then
      . exec/system/config/${DISTRIB_ID,,}/config.sh
    fi
    
    if [ -f "exec/system/config/${DISTRIB_ID,,}/${DISTRIB_RELEASE,,}/config.sh" ]; then
      . exec/system/config/${DISTRIB_ID,,}/${DISTRIB_RELEASE,,}/config.sh
    fi
    
    if [ -f "exec/local/system/config/${DISTRIB_ID,,}/config.sh" ]; then
      . exec/system/config/${DISTRIB_ID,,}/config.sh
    fi
    
    if [ -f "exec/local/system/config/${DISTRIB_ID,,}/${DISTRIB_RELEASE,,}/config.sh" ]; then
      . exec/system/config/${DISTRIB_ID,,}/${DISTRIB_RELEASE,,}/config.sh
    fi
fi

if [ -f "$(dirname $0)/check.sh" ]; then
    . $(dirname ${BASH_SOURCE[1]})/check.sh
    mne_checksys
fi


