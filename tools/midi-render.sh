#!/bin/bash

cd "$(dirname "$0")" ;

for file in ~/Dropbox/Delat/Nattradion/celler/*/*.mid; do
    outfile=`basename "${file/.mid/.wav}"`
    soundfont=$2
    fluidsynth -T wav -F "$outfile" "$soundfont" "$file"
    lame "$outfile" "${outfile/.wav/.mp3}"
    rm "$outfile"
done

