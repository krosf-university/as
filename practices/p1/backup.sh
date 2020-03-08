#!/bin/sh

DIR_PATH="$1"
DIR_BACKUP="$HOME/tests"

for dir in `find $DIR_PATH -type d -maxdepth 1 ! -path "."`; do
  dirname=$(basename -- "$dir")
  compressname="$DIR_BACKUP/$dirname`date "+_%Y%m%d"`.tgz"
  tar -czvf $compressname $dir
done