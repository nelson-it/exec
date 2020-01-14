#!/bin/bash

. exec/system/shell/allg/db.sh

getdomain="SELECT t0.domain, t0.workgroup, t0.typ, t0.description, t0.netdevice, t0.primaryname, t0.primaryaddr, 
                  t0.dnsforwarder, t0.dnssearch, t0.dhcpstart, t0.dhcpend, t0.dhcp6start, t0.dhcp6end, t1.addr, t1.addr6, t1.mask, t1.mask6, t1.broadcast
           FROM mne_system.domain t0 LEFT JOIN mne_system.network t1 ON ( t0.domainid = t1.hostname AND t0.netdevice = t1.networkid ) 
           WHERE t0.domainid='$(hostname)';"
get_domain()
{
    par=$1
    domain=${par/%%%%*};  par=${par#*%%%%}
    workgroup=${par/%%%%*}; par=${par#*%%%%}
    typ=${par/%%%%*}; par=${par#*%%%%}
    description=${par/%%%%*}; par=${par#*%%%%}
    netdevice=${par/%%%%*}; par=${par#*%%%%}
    primaryname=${par/%%%%*}; par=${par#*%%%%}
    primaryaddr=${par/%%%%*}; par=${par#*%%%%}
    dnsforwarder=${par/%%%%*}; par=${par#*%%%%}
    dnssearch=${par/%%%%*}; par=${par#*%%%%}
    dhcpstart=${par/%%%%*}; par=${par#*%%%%}
    dhcpend=${par/%%%%*}; par=${par#*%%%%}
    dhcp6start=${par/%%%%*}; par=${par#*%%%%}
    dhcp6end=${par/%%%%*}; par=${par#*%%%%}
    addr=${par/%%%%*}; par=${par#*%%%%}
    addr6=${par/%%%%*}; par=${par#*%%%%}
    mask=${par/%%%%*}; par=${par#*%%%%}
    mask6=${par/%%%%*}; par=${par#*%%%%}
    bcast=${par/%%%%*}; par=${par#*%%%%}
    
    dcdomain=$(echo "$domain" | sed -e 's/\./,DC=/g' -e 's/^/DC=/')
}
