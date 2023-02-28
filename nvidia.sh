#!/bin/bash

alias nm='nvidia-smi'

alias nml='nvidia-smi -l'
alias nmlm='nvidia-smi -lms'

alias nmls='nvidia-smi -l 10'  # slow
alias nmlr='nvidia-smi -l 1'  # regular (medium)
alias nmlf='nvidia-smi -lms 100'  # fast
