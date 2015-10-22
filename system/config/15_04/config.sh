#!/bin/bash

psql=/usr/bin/psql

apache2sitedir=/etc/apache2/sites-available
apache2ensite=a2ensite
apache2reload="service apache2 reload"

netinterfaces=/etc/network/interfaces