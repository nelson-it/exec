#!/bin/bash

function find_template()
{
   if [ -f "exec/system/templates/$SYSVERSION/$2/$IMPL/$3" ]; then
     eval $1=exec/system/templates/$SYSVERSION/$2/$IMPL/$3;
     return
   fi
   
   if [ -f "exec/system/templates/default/$2/$IMPL/$3" ]; then
     eval $1=exec/system/templates/default/$2/$IMPL/$3;
     return
   fi
   
   if [ -f "exec/system/templates/$SYSVERSION/$2/default/$3" ]; then
     eval $1=exec/system/templates/$SYSVERSION/$2/default/$3;
     return
   fi
   
   if [ -f "exec/system/templates/default/$2/default/$3" ]; then
     eval $1=exec/system/templates/default/$2/default/$3;
     return
   fi
   
   echo "File not found $2 $3" 1>&2 
   exit -1
} 