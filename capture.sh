#!/bin/bash

alias crs='wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -t <<< y'
alias rec='wf-recorder -a <<< y'
