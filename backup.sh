#!/bin/bash

back () {
    root=./

    filename=$1
    backup_suffix=.back

    pad_size=3


    if [[ -z $filename ]]; then
        raise 'Filename is required'
    fi

    if [ ! -f "$filename" ]; then
        raise "File $filename does not exist"
    fi

    max_previous_index=0

    for file in ./*; do
        non_index_part=$root$filename$backup_suffix.
        if [[ "$file" == $non_index_part* ]]; then
            index=$(echo $file | sed "s#$non_index_part##g")

            if (( $index > $max_previous_index )); then
                max_previous_index=$index
            fi
        fi
    done

    printf -v current_index "%0${pad_size}d" $((max_previous_index + 1))

    mv $filename $root$filename$backup_suffix.$current_index
}
