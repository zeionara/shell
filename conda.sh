#!/bin/bash

alias ca='conda'

# activate

alias caa='conda activate'

# create

cac () {
    if [ -z $2 ]; then
        conda create -n $1
    else
        conda create -n $1 python=$2
    fi
}

cacf () {
    path=${1:-environment.yml}

    if [ -z $2 ]; then
        conda env create -f $path
    else
        conda create -n $2 -f $path
    fi
}

# duplicate (clone)

cad () {
    conda create --clone $1 --name $2
}

# export

cae () {
    path=${1:-environment.yml}
    conda env export | grep -v "^prefix: " > $path
}


# install

alias cai='conda install'
alias caip='python -m pip install'

# list

alias cal='conda info --envs'

# rename

car () {
    conda rename -n $1 $2
}

# search

cas () {
    conda search -f $1
}

# upgrade

alias cau='conda update'
alias caus='conda update -n base -c defaults conda'

# version

alias caz='conda --version'
