#!/bin/sh

AUTHOR=$1
YEAR=$2

git log --date=short --format='%cd' --author="$AUTHOR" \
  --shortstat --before=$(($YEAR+1))-01-01 --after=$YEAR-01-01 | \
  awk '/[0-9]{4}-[0-9]{2}-[0-9]{2}/ {date=$1;next;} /^$/ {next;} {print date , ($4 +$6)}' | sort
