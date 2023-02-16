#!/bin/bash

alias rsrc='. ~/.bashrc'

loop () {
    for i in $(seq $1); do
        eval ${@:2}
    done
}
