#!/bin/zsh

_spec () {
  local description="$1"
  shift  # Remove the first argument (description)

  bindkey -M menuselect '^M' .accept-line

  _wanted -V values expl "$description" compadd -P '$' "$@"
}

_setup_ee_completions=$(
  echo _spec "history" $(
    cat "$HOME/.zsh_history" |
    grep -E '^[^a-zA-Z]+echo\s+\$[A-Z_]+$' |
    # cut -c 21- | cut -d ' ' -f 1- |
    cut -c 22- | cut -d ' ' -f 1 |
    sort |
    uniq -c |
    sort -nr |
    cut -d ' ' -f 8- |
    # sed 's/"/\\"/g' |
    # sed 's/\\n/\\\\\\\\n/g' |
    # sed -E 's/(.*)/"\1"/' |
    sed -E "s/(.*)/'\1'/" |
    tr '\n' ' '
    # sed 's/\$/\\$/g'
  )
)
# echo "$foo"
# eval "$foo"

_echo () {
  eval "$_setup_ee_completions"
}

ee () {
    echo $1
    bindkey -M menuselect -r '^M'
}

compdef _echo ee
