#!/bin/bash

ki () {
  local search_term="$1"

  if test "$search_term"; then
    sudo bash -c "ps -aux | grep '$search_term' | grep -v grep | awk '{print \$2}' | xargs kill"
  else
    echo 'Search term must not be empty'
  fi
}

pl () {
  local search_term="$1"

  if test "$search_term"; then
    # ps -aux | grep "$search_term" | grep -v grep | awk '{print $1, $2, $11}'
    ps -aux | grep "$search_term" | grep -v grep | awk '{ printf "%s %s ", $1, $2; for (i=11; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS) }'
  else
    echo 'Search term must not be empty'
  fi
}
