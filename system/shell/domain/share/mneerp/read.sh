#!/bin/bash

. exec/system/shell/allg/db.sh

getreleases="SELECT DISTINCT t0.name, t0.location, t0.description
           FROM mne_application.folder t0
             LEFT JOIN ( SELECT tt0.folderid, count(tt1.personid)
                           FROM mne_system.shares tt0 
                             LEFT JOIN mne_crm.personowndata tt1 ON ( tt0.personid = tt1.personid AND tt1.loginname IS  NOT NULL )
                           GROUP BY tt0.folderid ) t1 ON ( t0.folderid = t1.folderid ) 
              WHERE t1.folderid IS NOT NULL AND t0.hostname = '$(hostname)'
           ORDER BY t0.name"

getrelease="SELECT DISTINCT t0.name, t0.location, t0.description FROM mne_application.folder t0 WHERE t0.folderid ='par1' AND t0.hostname = '$(hostname)'"

get_releases()
{
    par=$1
    name=${par/%%%%*};        par=${par#*%%%%}
    location=${par/%%%%*};    par=${par#*%%%%}
    description=${par/%%%%*}; par=${par#*%%%%}
}

getvalidusers="SELECT DISTINCT t2.loginname, CASE WHEN t1.readwrite THEN 'rw' ELSE 'r' END\
           FROM mne_application.folder t0 \
             LEFT JOIN mne_system.shares t1 ON ( t0.folderid = t1.folderid ) \
             LEFT JOIN mne_crm.personowndata t2 ON ( t1.personid = t2.personid ) \
           WHERE t0.name = 'par1' AND t1.folderid IS NOT NULL AND t2.loginname != '' AND t0.hostname = '$(hostname)'"

get_validusers()
{
    par=$1
    user=${par/%%%%*};        par=${par#*%%%%}
    readwrite=${par/%%%%*};   par=${par#*%%%%}
}
