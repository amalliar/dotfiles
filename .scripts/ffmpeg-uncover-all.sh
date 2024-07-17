#!/bin/env zsh

mkdir uncovered ; for file in *.(flac|mp3|wav|ogg|opus) ; do ffmpeg -i "$file" -map 0:0 -c:a copy uncovered/"$file" ; done
