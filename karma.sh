#!/bin/bash

pumch () {
    folder=$1

    if test -z "$folder"; then
        echo 'Folder name must not be empty'
        exit
    fi

    local _path=$HOME/raconteur/assets/$folder

    # python -m karma sync $HOME/raconteur/assets/$_path music/2ch

    for file in $_path/speech/*.mp3; do
        echo Uploading file $file...
        python -m karma push $file music/2ch/$folder/$(basename $file)
    done
}
