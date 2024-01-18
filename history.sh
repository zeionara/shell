#!/bin/bash

rpt () {
  items=()

  while IFS= read -r line; do
    items+=("$line")
  done < <(tail -n 10 ~/.zsh_history | cut -d ';' -f2-)

  echo 'Type the number corresponding to the command you want to execute:\n'
  i=0

  for item in "${items[@]}"; do
    echo $i: $item
    i=$((i + 1))
  done

  echo -n '\nchoose a command> '
  read selected_i

  if ! [[ $selected_i =~ ^[0-9]$ ]]; then
    echo "\nGot invalid input from user: '$selected_i'. Exiting now"
    return
  fi

  selected_i=$((selected_i + 1))
  item="${items[$selected_i]}"

  echo "\nExecuting command '$item'...\n"

  eval $item
}
