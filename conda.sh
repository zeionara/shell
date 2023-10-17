#!/bin/bash

alias ca='conda'

# activate

# alias caa='conda activate'

caa () {
    conda activate $1
}

if [ "$ZSH" ]; then
    _caa () {
        if [ -z "$_ENV_CACHE" ]; then
            envs="$(conda env list | grep -v '^#' | cut -d ' ' -f 1 | head -n -1 | tr '\n' ' ')"
            export _ENV_CACHE="$envs"
        fi

        eval "compadd $_ENV_CACHE"
    }

    compdef _caa caa
fi

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
        conda env create -n $2 -f $path
    fi
}

# duplicate (clone)

cad () {
    conda create --clone $1 --name $2
}

# export

cae () {
    _path=${1:-environment.yml}
    conda env export | grep -v "^prefix: " > $_path
}

# fetch (update)

caff () {
    path=${1:-environment.yml}

    conda activate $(head $path -n 1 | awk '{print $2}')
    conda env update --file $path --prune
}


# install

alias cai='conda install'
alias caip='python -m pip install'

# list

alias cal='conda info --envs'

# patch

caph () {
    export PATH=$CONDA_PREFIX/bin:$PATH
}

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
