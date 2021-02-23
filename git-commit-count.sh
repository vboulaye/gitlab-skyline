#!/bin/bash

AUTHOR=$1
YEAR=$2
#set -x
# git log --date=short --format='%ad' --before=$(($YEAR+1))-01-01 --after=$YEAR-01-01 --author="$AUTHOR" --use-mailmap |sort |uniq -c | awk '{print $2 " " $1}'

if [ ! "$3" = "" ]
then
   cd "$3"
fi
git log --date=short --format='%ad' --author="$AUTHOR" \
   --use-mailmap |grep -e "^$YEAR" | sort |uniq -c | awk '{print $2 " " $1}'
