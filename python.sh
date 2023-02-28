#!/bin/bash

alias pn='python'
alias pp='pip'

alias pnt='python -m unittest'

pntd () {
    path=${1:-test}

    python -m unittest discover $path
}

alias pntt='python -m unittest test'
