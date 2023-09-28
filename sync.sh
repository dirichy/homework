file=$1
path=${file%/*}
fpath=${path##*/}
if [ $fpath = "solution" ] ; then
 mkdir "$path/.dontsync"
fi
if [ $fpath = "problem" ] ; then
 issync=$(awk 'END {print}' $file)
 result=$(echo $issync | grep "%please_sync_me_to_solution")
 if [ "$result" != "" ] ; then
  spath="${path%/*}/solution/"
  if [ -d "$spath/.dontsync" ] ; then
   exit 0
  fi
   cp $file "$spath${file##*/}"
 fi
fi
