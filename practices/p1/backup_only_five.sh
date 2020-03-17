#!/bin/sh

DIR_PATH="/importante"
DIR_BACKUP="/media/backup"

for dir in `find $DIR_PATH -type d -maxdepth 1 ! -path "."`; do
  dirname=$(basename -- "$dir")
  FOUND=`find $DIR_BACKUP -name "$dirname""_*.tgz" | sort`
  COPIES=`echo $FOUND | wc -l`
  [[ COPIES -eq 5 ]] && rm -f `echo $FOUND | head -1`
  compressname="$DIR_BACKUP/$dirname`date "+_%Y%m%d"`.tgz"
  tar -czvf $compressname $dir
done