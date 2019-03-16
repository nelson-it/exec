function mne_need_error()
{
  mne_error_ignore=10
  errorresult=0
}
function mne_error_handler()
{
# Aufruf mit: trap 'mne_error_handler $BASH_COMMAND $LINENO $?' ERR
    
  errorresult=$?
  if [ "`type -t script_error_handler`" = "function" ]; then
    script_error_handler $1 $2 $3
  fi
    
  if [ "$mne_error_ignore" = "1" ]; then
    return;
  fi
  
  if [ "$mne_error_ignore" = "10" ]; then
    mne_error_ignore=
    return;
  fi
  
  stack=$(echo "$1" | sed -e 's/ /\n          /g');
  echo "error found: " 1>&$stderr
  echo "error in: $0" 1>&$logfile
  echo "   stack: $stack" 1>&2
  echo "    line: $2" 1>&2
  echo "  status: $3" 1>&2
  echo "   error: $errorresult" 1>&2
    
  if [ "$noexit" = "1" ]; then
    noexit=0
    return;
  fi
  exit 1
}

function cleanup
{
  ifconfig lo:mneconfig 127.0.156.1 netmask 255.255.255.0 down
  
  echo End ===================================================================== 1>&$logfile
  sleep 0
}

function mne_checksys()
{
   for i in "${sysok[@]}"
   do
      if [ "${DISTRIB_ID,,}_${DISTRIB_RELEASE,,}" = "$i" ]; then
        return;
      fi
   done
      
   echo "${BASH_SOURCE[1]}: system ${DISTRIB_ID,,}_${DISTRIB_RELEASE,,} not supported" 1>&2
   exit 2;
 }
    
function save_file()
{
  savedfile=
  if [ -f "$1" ]; then
    cp $1 $1""_$actdate
    savedfile=$1""_$actdate
  elif [ -e "$1" ]; then
    mv $1 $1""_$actdate
    savedfile=$1""_$actdate
  fi
}
    
function toupper()
{
  echo "$1"| awk '{print toupper($0)}'
}
    
function tolower()
{
  echo "$1"| awk '{print tolower($0)}'
}
    
function Tolower()
{
  echo "$1"| awk '{printf("%s%s", toupper(substr($0,0,1)), tolower(substr($0,2))) }'
}
    
function pg_adduser()
{
  ifconfig lo:mneconfig 127.0.156.1 netmask 255.255.255.0 up
  su - postgres -c "echo \"CREATE ROLE $1; ALTER ROLE $1 LOGIN;\" | psql -h 127.0.156.1 >$logfile 2>&1; exit 0"; 
  ifconfig lo:mneconfig 127.0.156.1 netmask 255.255.255.0 down
}
    
function pg_addaccess()
{
  ifconfig lo:mneconfig 127.0.156.1 netmask 255.255.255.0 up
  pg_hba=$(echo 'show hba_file' | psql --set ON_ERROR_STOP=on --tuples-only --no-align --field-separator '%%%%'  -U postgres -h 127.0.156.1)
  ifconfig lo:mneconfig 127.0.156.1 netmask 255.255.255.0 down

  egrep $1 $pg_hba >$logfile 2>&1
  if [ ! "$?" = "0" ]; then
    mv  $pg_hba $pg_hba"".orig 

    echo "$2"            > $pg_hba
    cat $pg_hba"".orig  >> $pg_hba
    chown postgres:postgres $pg_hba
    su - postgres -c "$(pg_config --bindir)/pg_ctl reload -D $(dirname $pg_hba)" >$logfile 2>&1
  fi
}
    
 