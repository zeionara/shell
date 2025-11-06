#!/bin/bash


hide () {
    src=${1:-.env}
    dst=$src.hidden

    if [ `cat $src | grep -c "@hide"` -lt 1 ]; then
        echo No data to hide
        return
    fi

    mv $src $dst
    sed -E "s/([A-Z_]+\s*=\s*['\"]*)[^ '\"]+(['\"]*)  # @hide$/\1hidden\2/g" $dst > $src

    chmod --reference=$dst $src
}

show () {
    src=${1:-.env}
    dst=$src.hidden

    if test ! -f $dst; then
        echo No file to read hidden data from
        return
    fi

    mv $dst $src
}
