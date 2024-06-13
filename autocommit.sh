#!/bin/bash

INPUT_PATH=$1
OUTPUT_PATH=$2

inotifywait -r -m -e close_write --exclude '/\..+' $INPUT_PATH | while read path action file; do
    rsync --progress -avr $INPUT_PATH $OUTPUT_PATH
    git -C $OUTPUT_PATH add .
    git -C $OUTPUT_PATH commit -m "Auto commit"
done