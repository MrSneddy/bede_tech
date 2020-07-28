#!/bin/sh
#
# removal of files over 7 days old if the filesystem is over 90%
#
dir="/home/scriptadmin/test"
days=7

df -H | grep -vE '^Filesystem|tmpfs|cdrom|loop*|udev' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 90 ]; then
    echo -n "removing files in $dir that are older than $days days: "
    find "$dir" -mtime +$days -type f -exec echo {} \; -exec rm {} \; | wc -l
  fi
done
