#!/bin/bash

alias gha='gh cs start'

ghh () {
  keyphrase="$1"

  gh cs ssh -c "$(gh cs list | head -n 2 | grep "$keyphrase" | tail -n 1 | cut -f 1)"
}

ghproxy () {
  keyphrase="$1"

  gh cs ssh -c "$(gh cs list | head -n 2 | grep "$keyphrase" | tail -n 1 | cut -f 1)" 'cd /workspaces/much && conda run -n much --no-capture-output python -m much start-proxy'
}

alias ghl='gh cs list'

ghp () {
  name="$1"

  gh cs cp -e remote:/workspaces/much/assets/$name.txt "$HOME/raconteur/assets/"
}

alias ghz='gh cs stop'
