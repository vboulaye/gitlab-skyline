#!/bin/bash

AUTHOR=$1
YEAR=$2

git log --date=short --format='%cd' --before=$(($YEAR+1))-01-01 --after=$YEAR-01-01 --author="$AUTHOR"  |sort |uniq -c | awk '{print $2 " " $1}'
