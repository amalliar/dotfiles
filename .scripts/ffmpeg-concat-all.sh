#!/bin/env sh

ffmpeg -f concat -safe 0 -i <(for f in ./*.flac; do echo "file '$PWD/$f'"; done) output.flac
