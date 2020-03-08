#!/bin/sh

DIRECTORY="${1%/}"
PAD_FORMAT="%05g"

[[ -d $DIRECTORY ]] || { echo "🚨  The argument should be an directory"; exit 2; }

sequence=0

for file in `find $DIRECTORY -type f -maxdepth 1`; do
  filename=$(basename -- "$file")
  extension="${filename##*.}"
  filename="${file%.*}"
  newname="$DIRECTORY/`seq -f $PAD_FORMAT $sequence $sequence`.$extension"
  echo "$newname"
  let sequence=sequence+1
done
