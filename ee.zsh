#!/bin/zsh

_spec () {
  local description="$1"
  shift  # Remove the first argument (description)

  bindkey -M menuselect '^M' .accept-line

  _wanted -V values expl "$description" compadd -P '$' "$@"
}

_spec_no_prefix () {
  local description="$1"
  shift  # Remove the first argument (description)

  bindkey -M menuselect '^M' .accept-line

  _wanted -V values expl "$description" compadd "$@"
}

_spec_directories () {
  local description="$1"
  shift  # Remove the first argument (description)

  bindkey -M menuselect '^M' .accept-line

  # _wanted -V values expl "$description" compadd -J directory "$@"
  compadd -V directories -x directories "$@"
  compadd -V files -x files _files
}

# cat "$HOME/.zsh_history" | grep -E '^[^a-zA-Z]+echo\s+\$[A-Z_]+$' | cut -c 22- | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | cut -d ' ' -f 8- | sed -E "s/(.*)/'\1'/" | tr '\n' ' '

_get_ee_options () {
  get_counts () {
    echo "$(
      cat "$HOME/.zsh_history" |
      grep -E '^[^a-zA-Z]+echo\s+\$[A-Z_]+$' |
      cut -c 22- |
      cut -d ' ' -f 1 |
      sort |
      uniq -c |
      sort -nr
    )"
  }

  counts="$(get_counts)"

  export __max_count=$(echo "$counts" | head -n 1 | awk '{print $1}')
  export __history_length=$(cat "$HOME/.zsh_history" | wc -l)

  cat "$HOME/.zsh_history" |
  grep -E '^[^a-zA-Z]+echo\s+\$[A-Z_]+$' |
  cut -c 22- |
  cut -d ' ' -f 1 |
  sort |
  uniq -c -w1 |
  awk '{print $2, $1}' |
  sed -E 's#(([^ ]+).*)$#echo \1 $(tac "$HOME/.zsh_history" | grep -n "\2" | cut -d ":" -f 1 | head -n 1)#' |
  zsh 2>/dev/null |
  # awk '{first = $2 * 0.5; second = $3 * 0.2; sum = first + second; print $1, $2, first, $3, second, sum}'
  awk '{first = $2 / ENVIRON["__max_count"]; second = 1 - $3 / ENVIRON["__history_length"]; count_weight = 0.3; sum = count_weight * first + (1 - count_weight) * second; print sum, $1}' |
  sort -nr |
  cut -d ' ' -f 2- |
  sed -E "s/(.*)/'\1'/"
}

_ee_options=$(_get_ee_options | tr '\n' ' ')

_setup_ee_completions=$(
  echo _spec "history" $_ee_options
  # $(
  #   # _get_ee_options
  #   cat "$HOME/.zsh_history" |
  #   grep -E '^[^a-zA-Z]+echo\s+\$[A-Z_]+$' |
  #   # cut -c 21- | cut -d ' ' -f 1- |
  #   cut -c 22- | cut -d ' ' -f 1 |
  #   sort |
  #   uniq -c |
  #   sort -nr |
  #   cut -d ' ' -f 8- |
  #   # sed 's/"/\\"/g' |
  #   # sed 's/\\n/\\\\\\\\n/g' |
  #   # sed -E 's/(.*)/"\1"/' |
  #   sed -E "s/(.*)/'\1'/" |
  #   tr '\n' ' '
  #   # sed 's/\$/\\$/g'
  # )
)

_setup_ee_completions_no_prefix=$(
  echo _spec_no_prefix "history" $_ee_options
)
# echo "$_setup_ee_completions"
# eval "$foo"

_echo () {
  eval "$_setup_ee_completions"
}

_echo_no_prefix () {
  eval "$_setup_ee_completions_no_prefix"
}

ee () {
    echo $1
    bindkey -M menuselect -r '^M'
}

# echo "$_setup_ee_completions"
# echo "$_setup_ee_completions_no_prefix"

compdef _echo_no_prefix ee '-parameter-'
compdef _echo ee

# zstyle ':completion::complete:-parameter-::' parameter _echo
# zstyle ':completion::complete:-parameter-::' parameter _echo
# zstyle ':completion::complete-fuzzy:-parameter-::' parameter _echo
# zstyle ':completion::complete:-parameter-::' completer _echo
# zstyle ':completion::complete-fuzzy:-parameter-::' completer _echo
# compdef _echo ee

# zstyle ':completion:*:-parameter-:*' completer _echho
# zstyle ':completion::complete:ee::' completer _echo
# zstyle ':completion:*:*:ee:*' completer _echo
# zstyle ':completion:*' completer _echo

# zstyle ':completion:*:complete:ee:*:directories' sort reverse
# zstyle ':completion:*:complete:ee:*:parameters' sort reverse
# zstyle ':completion:*:complete:-parameter-:*:parameters' sort reverse
# zstyle ':completion:*:complete:-parameter-:*:parameters' completer _echo

# zstyle ':completion::complete-fuzzy:-parameter-::' completer _echo
