#!/bin/env zsh

mkdir covered ; for file in *.(flac|mp3|wav|ogg|opus) ; do ffmpeg -i "$file" -i cover.jpg -map_metadata 0 -map 0 -map 1 -acodec copy -disposition:v attached_pic covered/"$file" ; done
