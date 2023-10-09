#!/bin/bash

alias pn='python'
alias pp='pip'

alias pnt='python -m unittest'

pntd () {
    path=${1:-test}

    python -m unittest discover $path
}

alias pntt='python -m unittest test'

# tensorflow

_tfg () {
    echo 'Listing gpus...'
    python -c 'import tensorflow as tf; print(tf.config.list_physical_devices("GPU"))'
}

tfgv () {
    export TF_CPP_MIN_LOG_LEVEL=0
    # echo $TF_CPP_MIN_LOG_LEVEL
    _tfg
}

tfg () {
    export TF_CPP_MIN_LOG_LEVEL=3
    # echo $TF_CPP_MIN_LOG_LEVEL
    _tfg
}
