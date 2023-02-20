#!/bin/bash

export GPG_TTY=$(tty)

raise () {
    : "${__raise:?$1}"
}

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

# back () {
#     mv $1 $1.backup
# }

. $HOME/bash-tools/ssh.sh
. $HOME/bash-tools/gpg.sh
. $HOME/bash-tools/backup.sh
