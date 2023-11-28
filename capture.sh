#!/bin/bash

alias crs='wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -t <<< y'

alias rec='wf-recorder -a <<< y'
alias recg='wf-recorder -a -g "$(slurp)" <<< y'

alias wr='wf-recorder'
alias wrg='wf-recorder -g "$(slurp)"'

alias glw='gst-launch-1.0 v4l2src device=/dev/video0 ! videoconvert ! waylandsink'
