#!/bin/bash

export GPG_TTY=$(tty)  # TODO: remove duplicate from bashrc project

BASH_TOOLS_ROOT=$HOME/bash-tools

raise () {
    : "${__raise:?$1}"
}

src () {
    . $HOME/$1/.bashrc
}

rsrc () {
    __conda_prefix=$CONDA_PREFIX

    . ~/.bashrc

    if [ ! -z $__conda_prefix ]; then
        env_name=`basename $__conda_prefix`
        if [ "$env_name" != "anaconda3" ] && [ "$env_name" != "conda" ]; then
            conda activate "$env_name"
        fi
    fi
}
# alias rsrc='. ~/.bashrc'

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

settup () {
    curl -Ls https://cutt.ly/setup-$1
}

setup () {
    settup $1 | bash
}

ctls () {
    cat $1 | less
}

ctgp () {
    cat $1 | grep $2
}

ctgpi () {
    cat $1 | grep $2 -v
}

lsgp () {
    if [ -z $2 ]; then
        ls | grep $1
    else
        ls $1 | grep $2
    fi
}

lsagp () {
    if [ -z $2 ]; then
        ls -alh | grep $1
    else
        ls -alh $1 | grep $2
    fi
}

scg () {  # SpaCe Global
    df -h / | sort -rh
}

sc () {  # SpaCe
    sudo du -h ${1:-.} -d 1 | sort -rh
}

scls () {  # SpaCe
    sudo du -h ${1:-.} -d 1 | sort -rh | less
}

trc () {
    tar -cJvf $2.tar.xz -C $1 ./
}

trx () {
    mkdir $1
    tar -xJvf $2.tar.xz -C $1
}

apx () {
    if [ -z $2 ]; then
        for file in *.*; do
            mv $file $1-$file
        done
    else
        for file in $1/*.*; do
            mv $file $1/$2-$(basename $file)
        done
    fi
}

n-lines () {
    echo $(find "$@" -name '*.*' -type f | xargs wc -l | tail -n 1 | sed -E 's/\s+/ /g' | cut -d ' ' -f 2) lines
}

cpc () {
    cp $1 $(dirname $1)/$2
}

. $BASH_TOOLS_ROOT/ssh.sh
. $BASH_TOOLS_ROOT/gpg.sh
. $BASH_TOOLS_ROOT/backup.sh

. $BASH_TOOLS_ROOT/conda.sh
. $BASH_TOOLS_ROOT/python.sh

. $BASH_TOOLS_ROOT/nvidia.sh
. $BASH_TOOLS_ROOT/ffmpeg.sh

. $BASH_TOOLS_ROOT/nuxt.sh
. $BASH_TOOLS_ROOT/apt.sh

. $BASH_TOOLS_ROOT/mongo.sh
. $BASH_TOOLS_ROOT/error.sh

. $BASH_TOOLS_ROOT/search.sh
