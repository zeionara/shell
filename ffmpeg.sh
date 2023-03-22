#!/bin/bash

to_mp3 () {
    audio_rate=${2:-44100}

    converted_path="$(echo $1 | rev | cut -f2- -d '.' | rev).mp3"

    ffmpeg -i "$1" -acodec libmp3lame -ar $audio_rate "$converted_path"
}
