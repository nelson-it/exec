#!/bin/bash

. exec/system/shell/allg/db.sh

getinterfaces="SELECT t0.networkid, t0.typ, t0.addr, t0.mask, t0.broadcast, t0.gateway, t0.nameserver, COALESCE(t1.domain, t0.domain), t0.search FROM mne_system.network t0 LEFT JOIN mne_system.domain t1 ON ( t0.hostname = t1.domainid ) WHERE hostname ='$(hostname)' ORDER BY networkid;"
getsingleinterface="SELECT t0.networkid, t0.typ, t0.addr, t0.mask, t0.broadcast, t0.gateway, t0.nameserver, COALESCE(t1.domain, t0.domain), t0.search FROM mne_system.network t0 LEFT JOIN mne_system.domain t1 ON ( t0.hostname = t1.domainid ) WHERE hostname = '$(hostname)' AND networkid = 'par1';"

get_interfaces()
{
    par=$1
    device=${par/%%%%*};     par=${par#*%%%%}
    typ=${par/%%%%*};        par=${par#*%%%%}
    addr=${par/%%%%*};       par=${par#*%%%%}
    mask=${par/%%%%*};       par=${par#*%%%%}
    bcast=${par/%%%%*};      par=${par#*%%%%}
    gw=${par/%%%%*};         par=${par#*%%%%}
    nameserver=${par/%%%%*}; par=${par#*%%%%}
    domain=${par/%%%%*};     par=${par#*%%%%}
    search=${par/%%%%*};     par=${par#*%%%%}
}
