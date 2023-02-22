#!/bin/bash

alias ca='conda'

# list

alias cal='conda info --envs'

# rename

car () {
    conda rename -n $1 $2
}

# alias

alias caz='conda --version'
