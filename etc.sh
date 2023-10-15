#!/bin/bash

# colors

export GREEN=10
export BLUE=12
export RED=196
export FUCHSIA=213
export YELLOW=226

alias palette='for code in {000..255}; do print -P -- "$code: %B%F{$code}Color%f"; done'

color () {
    code=$1

    if [[ $code -lt 0 ]] || [[ $code -gt 255 ]]; then
        echo "Color code must be in the interval [0; 255]"
        return
    fi

    print -P "$code: %B%F{$code}Color%f"
}

alias home="cd $HOME"
