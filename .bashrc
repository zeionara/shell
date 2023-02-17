#!/bin/bash

src () {
    . $HOME/$1/.bashrc
}

alias rsrc='. ~/.bashrc'

loop () {
    for i in $(seq $1); do
        eval ${@:2}
    done
}

cdd () {
    cd $1 && ls
}

cddv () {
    cd $1 && ls -alh
}

. $HOME/bash-tools/ssh.sh
. $HOME/bash-tools/gpg.sh
