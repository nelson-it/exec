#!/bin/bash

. exec/system/shell/allg/db.sh

getinterfaces="SELECT t0.networkid, t0.typ, t0.addr, t0.mask, 
                      t0.addr6, t0.mask6, t0.broadcast, t0.gateway,
                      CASE WHEN t1.typ = E'standalone' THEN t0.nameserver ELSE COALESCE(NULLIF(t2.addr6,''), NULLIF(t2.addr,''), E'127.0.0.1') END,                      COALESCE(t1.domain, t0.domain),
                      CASE WHEN t1.typ = 'standalone' THEN t0.search ELSE t1.dnssearch END
               FROM mne_system.network t0 
                 LEFT JOIN mne_system.domain t1 ON ( t0.hostname = t1.domainid )
                 LEFT JOIN mne_system.network t2 ON ( t2.hostname = t1.domainid AND t2.networkid = t1.netdevice )
               WHERE t0.hostname ='$(hostname)' ORDER BY networkid;"
               
getsingleinterface="SELECT t0.networkid, t0.typ, t0.addr, t0.mask, 
                      t0.addr6, t0.mask6, t0.broadcast, t0.gateway,
                      CASE WHEN t1.typ = E'standalone' THEN t0.nameserver ELSE COALESCE(NULLIF(t2.addr6,''), NULLIF(t2.addr,''), E'127.0.0.1') END,                      COALESCE(t1.domain, t0.domain),
                      CASE WHEN t1.typ = 'standalone' THEN t0.search ELSE t1.dnssearch END
               FROM mne_system.network t0 
                 LEFT JOIN mne_system.domain t1 ON ( t0.hostname = t1.domainid )
                 LEFT JOIN mne_system.network t2 ON ( t2.hostname = t1.domainid AND t2.networkid = t1.netdevice )
               WHERE t0.hostname = '$(hostname)' AND t0.networkid = 'par1';"

get_interfaces()
{
    par=$1
    device=${par/%%%%*};     par=${par#*%%%%}
    typ=${par/%%%%*};        par=${par#*%%%%}
    addr=${par/%%%%*};       par=${par#*%%%%}
    mask=${par/%%%%*};       par=${par#*%%%%}
    addr6=${par/%%%%*};      par=${par#*%%%%}
    mask6=${par/%%%%*};      par=${par#*%%%%}
    bcast=${par/%%%%*};      par=${par#*%%%%}
    gw=${par/%%%%*};         par=${par#*%%%%}
    nameserver=${par/%%%%*}; par=${par#*%%%%}
    domain=${par/%%%%*};     par=${par#*%%%%}
    search=${par/%%%%*};     par=${par#*%%%%}
}
