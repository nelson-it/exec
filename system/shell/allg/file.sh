#!/bin/bash

function find_template()
{
   if [ -f "exec/local/system/templates/$SYSVERSION/$2/$IMPL/$3" ]; then
     eval $1=exec/local/system/templates/$SYSVERSION/$2/$IMPL/$3;
     return
   fi
   
   if [ -f "exec/local/system/templates/default/$2/$IMPL/$3" ]; then
     eval $1=exec/local/system/templates/default/$2/$IMPL/$3;
     return
   fi
   
   if [ -f "exec/local/system/templates/$SYSVERSION/$2/$3" ]; then
     eval $1=exec/local/system/templates/$SYSVERSION/$2/$3;
     return
   fi
   
   if [ -f "exec/local/system/templates/default/$2/$3" ]; then
     eval $1=exec/local/system/templates/default/$2/$3;
     return
   fi
   if [ -f "exec/system/templates/$SYSVERSION/$2/$IMPL/$3" ]; then
      eval $1=exec/system/templates/$SYSVERSION/$2/$IMPL/$3;
     return
   fi
   
   if [ -f "exec/system/templates/default/$2/$IMPL/$3" ]; then
     eval $1=exec/system/templates/default/$2/$IMPL/$3;
     return
   fi
   
   if [ -f "exec/system/templates/$SYSVERSION/$2/$3" ]; then
     eval $1=exec/system/templates/$SYSVERSION/$2$3;
     return
   fi
   
   if [ -f "exec/system/templates/default/$2/$3" ]; then
     eval $1=exec/system/templates/default/$2/$3;
     return
   fi
   
   echo "File not found $2 $3" 1>&2 
   exit -1
} 

function find_script()
{
   if [ -f "exec/local/system/shell/$SYSVERSION/$1/$IMPL/$2" ]; then
    . exec/local/system/shell/$SYSVERSION/$12/$IMPL/$2;
     return
   fi

   if [ -f "exec/local/system/shell/$SYSVERSION/$1/$2" ]; then
     . exec/local/system/shell/$SYSVERSION/$1/$2;
     return
   fi

   if [ -f "exec/local/system/shell/$1/$IMPL/$2" ]; then
     . exec/local/system/shell/$1/$IMPL/$2;
     return
   fi

   if [ -f "exec/local/system/shell/$1/$2" ]; then
     . exec/local/system/shell/$1/$2;
     return
   fi

   if [ -f "exec/system/shell/$SYSVERSION/$1/$IMPL/$2" ]; then
     . exec/system/shell/$SYSVERSION/$1/$IMPL/$2;
     return
   fi

   if [ -f "exec/system/shell/$SYSVERSION/$1/$2" ]; then
     . exec/system/shell/$SYSVERSION/$1/$2;
     return
   fi

   if [ -f "exec/system/shell/$1/$IMPL/$2" ]; then
     . exec/system/shell/$1/$IMPL/$2;
     return
   fi

   if [ -f "exec/system/shell/$1/$2" ]; then
     . exec/system/shell/$1/$2;
     return
   fi
   
   echo "File not found $1 $2" 1>&2 
   exit -1
} 