#!/bin/bash

get_data()
{
   echo "\\pset format unaligned \\pset footer off \\pset  tuples_only \\\\ $1" | sed -e "s@par1@$2@g" -e "s@par2@$3@g" -e "s@par3@$4@g" -e "s@par4@$5@g" | $psql -h localhost -E  -U $DBUSER $DB | sed -e "1,3d"
}
