#!/bin/bash

. exec/system/shell/allg/db.sh

getconf="SELECT port, sport FROM mne_system.apache;"
get_conf()
{
    par=$1
    port=${par/%%%%*};  par=${par#*%%%%}
    sport=${par/%%%%*}; par=${par#*%%%%}
}
