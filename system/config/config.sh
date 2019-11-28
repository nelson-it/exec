#!/bin/bash

export PATH=/sbin:/usr/sbin:$PATH

basedir=/opt/mne_sys

psql=/usr/bin/psql

apache2rootdir=/etc/apache2

apache2confdir=/etc/apache2/conf-available
apache2sitedir=/etc/apache2/sites-available

apache2ensite=a2ensite
apache2enconf=a2enconf

apache2reload="systemctl reload apache2.service"
apache2restart="systemctl restart apache2.service"


certbasedir=$DATAROOT/cert
  certcadir=$certbasedir/ca
 certkeydir=$certbasedir/key
certcertdir=$certbasedir/cert
 certcsrdir=$certbasedir/csr
 certextdir=$certbasedir/extern

certscriptdir=exec/system/shell/cert

dhcpconf=/etc/dhcp
dhcpconfig=/etc/dhcp/dhclient.conf
dhcpgroup=dhcpd

bindconf=/etc/bind
apparmorconf=/etc/apparmor.d

sambaroot=/opt/mne/samba
sambabin=$sambaroot/bin
sambasbin=$sambaroot/sbin
sambaconf=/etc/mne/samba
sambavar=/var/lib/mne/samba

ldapconf=/etc/ldap

kerberosconfig=/etc/krb5.conf

dovecotconf=/etc/dovecot
postfixconf=/etc/postfix
