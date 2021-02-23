#!/bin/sh

AUTHOR=$1
YEAR=$2
#set -x

if [ ! "$3" = "" ]
then
   cd "$3"
fi

git log --date=short --format='%ad' --author="$AUTHOR" \
  --shortstat --use-mailmap |  \
  awk '/[0-9]{4}-[0-9]{2}-[0-9]{2}/ {date=$1;next;} /^$/ {next;} {print date , ($4 +$6)}' | grep -e "^$YEAR" | sort
