#!/bin/bash

. exec/system/shell/allg/db.sh

getreleases="SELECT name, location, description FROM mne_application.folder;"
get_releases()
{
    par=$1
    name=${par/%%%%*};        par=${par#*%%%%}
    location=${par/%%%%*};    par=${par#*%%%%}
    description=${par/%%%%*}; par=${par#*%%%%}
}
