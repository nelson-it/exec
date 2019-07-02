#!/bin/bash

. exec/system/shell/allg/db.sh

updateuser="UPDATE mne_crm.personowndata \
              SET unixid = par2, unixgrp = par3 \
            WHERE loginname = 'par1'"

getuser="SELECT \
                t0.\"loginname\" AS loginname,\
                t1.firstname || E' ' || t1.lastname AS fullname,\
                t0.unixid, t0.unixgrp\
              FROM\
                mne_crm.personowndata t0 LEFT JOIN mne_crm.person t1 ON ( t0.personid = t1.personid) \
              WHERE t0.\"loginname\" != ''"

get_user()
{
    par=$1
    user=${par/%%%%*};  par=${par#*%%%%}
    fullname=${par/%%%%*}; par=${par#*%%%%}
    uid=${par/%%%%*}; par=${par#*%%%%}
    gid=${par/%%%%*}; par=${par#*%%%%}
}

getshare="SELECT t0.\"loginname\", t2.name,  CASE WHEN t1.readwrite THEN '' ELSE ' Read' END
            FROM mne_crm.personowndata t0
              INNER JOIN mne_system.shares t1 ON ( t0.personid = t1.personid )
              LEFT JOIN mne_application.folder t2 ON ( t2.folderid = t1.folderid )
            WHERE t0.\"loginname\" = 'par1'"

get_share()
{
    par=$1
    user=${par/%%%%*};  par=${par#*%%%%}
    name=${par/%%%%*}; par=${par#*%%%%}
    read=${par/%%%%*}; par=${par#*%%%%}
}
            
getvaliduser="SELECT DISTINCT
                t2.\"loginname\" AS loginname,
                t1.firstname || E' ' || t1.lastname AS fullname
              FROM mne_system.shares t0 
                 LEFT JOIN mne_crm.person t1 ON ( t0.personid = t1.personid)
                 LEFT JOIN mne_crm.personowndata t2 ON ( t0.personid = t2.personid) 
              WHERE t1.personid IS NOT NULL AND t2.\"loginname\" IS NOT NULL"

get_validuser()
{
    par=$1
    user=${par/%%%%*};  par=${par#*%%%%}
    fullname=${par/%%%%*}; par=${par#*%%%%}
}
