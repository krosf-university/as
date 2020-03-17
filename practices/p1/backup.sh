#!/bin/sh

DIR_PATH="/importante"
DIR_BACKUP="/media/backup"

for dir in `find $DIR_PATH -type d -maxdepth 1 ! -path "."`; do
  dirname=$(basename -- "$dir")
  compressname="$DIR_BACKUP/$dirname`date "+_%Y%m%d"`.tgz"
  tar -czvf $compressname $dir
done