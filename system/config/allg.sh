#!/bin/bash

DBUSER=mneerprepository
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
 
if [ -f "exec/system/config/$SYSVERSION/config.sh" ]; then
  . exec/system/config/$SYSVERSION/config.sh
fi