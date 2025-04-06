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

    cp $filename $root$filename$backup_suffix.$current_index
}

__camback_counter=0

__camback () {
  src=$1
  dst=$2

  for file in $(adb shell ls $src); do
    if test ! -f $dst/$file; then
      src_file=$src/$file

      echo Backing up $src_file...
      adb pull $src_file $dst/$file
      __camback_counter=$((__camback_counter + 1))
    fi
  done
}

camback () {
  parent_path=${1:-/home/$USER/Documents}
  main_path=$parent_path/$(date '+%Y.%m.%d')

  root_path=$main_path/root
  sdcard_path=$main_path/sdcard

  __camback_counter=0

  __camback /storage/418B-A230/DCIM/Camera $main_path/sdcard $counter
  __camback /storage/self/primary/DCIM/Camera $main_path/root $counter

  if test $__camback_counter -eq 0; then
    echo Nothing to back up
  elif test $__camback_counter -eq 1; then
    echo Backed up $__camback_counter file
  else
    echo Backed up $__camback_counter files
  fi
}
