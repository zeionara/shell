#!/bin/zsh

frequency_weight=0.3

space_mark='__SPACE__'
slash_mark='__SLASH__'

__encode () {
  echo $@ |
    sed "s/ /$space_mark/g" |
    sed "s/\\\/$slash_mark/g"
}

__decode () {
  echo $@ |
    sed "s/$space_mark/ /g" |
    sed "s/$slash_mark/\\\\\\\/g"
}

__sort_by_relevance () {
  local terms=("$@")

  typeset -A frequencies
  typeset -A offsets
  typeset -A scores

  local history_path="$HOME/.zsh_history"

  local max_frequency=0
  local max_offset=0

  for term in "${terms[@]}"; do
    decoded_term="$(__decode $term)"

    local count=$(grep -c "$decoded_term" "$history_path")
    local offset=$(tac "$history_path" | grep -n "$decoded_term" | head -n 1 | cut -d: -f1)

    frequencies[$term]=$count
    offsets[$term]=$offset

    if ((count > max_frequency)); then
        max_frequency=$count
    fi

    if ((offset > max_offset)); then
        max_offset=$offset
    fi
  done

  for term in ${(ok)frequencies}; do
    local frequency=$frequencies[$term]
    local score=0.0000

    if ((frequency > 0)); then
      normalized_frequency=$((frequency * 1.0 / max_frequency))
      normalized_offset=$((1 - offsets[$term] * 1.0 / max_offset))

      score=$((frequency_weight * normalized_frequency + (1 - frequency_weight) * normalized_offset))
    fi

    scores[$term]=$score
  done

  local combined=()

  # for k v ("${(@kv)scores}") eval "combined+=('""$v $(echo $(__decode $k) | sed 's/'"'"'/'"'"'"'"'"'"'"'"'/g')\n""')"
  for k v ("${(@kv)scores}") combined+=("$v $k\n")

  echo $(echo ' '$combined | sort -k 1,1nr -k 2,2 | grep -v '^$' | cut -d ' ' -f4 | tr '\n' ' ')
}

# items=('bar' 'foo')
# 
# __sort_by_relevance $items

# items=('foo"'"'"'\  bar' 'baz  qux')

__ls () {
  # eval "_spec_no_prefix ddirectories 'bbashrc/' 'tools/' 'shell/' 'sentimeter/' 'boot/' 'colorful-prompt/' 'curl-tools/' 'docker-tools/' 'gen2/' 'tmux-config/' 'Documents/' 'miniconda3/' 'Desktop/' 'Downloads/' 'git-tools/' 'kubetools/' 'Music/' 'paste-token/' 'Pictures/' 'Public/' 'Templates/' 'Videos/'"

  items=()

  # for file in *(D); do
  for file in */; do
    items+=("$file")
  done

  # encode

  encoded_items=()

  for item in "${items[@]}"; do
    encoded_items+=($(__encode $item))
  done

  # sort

  sorted_items=($(__sort_by_relevance "${encoded_items[@]}"))

  # decode

  decoded_items=()

  for item in "${sorted_items[@]}"; do
    decoded_items+=("$(__decode $item)")
  done

  args=''
  for item in "${decoded_items[@]}"; do
    if test -z $args; then
      args="'$item'"
    else
      args="$args '$item'"
    fi
  done

  eval "_spec_no_prefix directories $args"
}

compdef __ls ls
# zstyle ':completion:*' group-order files directories
# zstyle ':completion:*:complete:ls:*' completer __ls

# typeset -A frequencies
# typeset -A offsets
# typeset -A scores

# hist="$HOME/.zsh_history"
#
# max_frequency=0
# max_offset=0
# 
# frequency_weight=0.3
# 
# for file in *(D); do
#     count=$(grep -c "$file" "$hist")
#     offset=$(tac "$hist" | grep -n "$file" | head -n 1 | cut -d: -f1)
# 
#     frequencies[$file]=$count
#     offsets[$file]=$offset
# 
#     if ((count > max_frequency)); then
#         max_frequency=$count
#     fi
# 
#     if ((offset > max_offset)); then
#         max_offset=$offset
#     fi
# done
# 
# for file in ${(ok)frequencies}; do
#     frequency=$frequencies[$file]
# 
#     if ((frequency == 0)); then
#         score=0.0000
#     else
#         normalized_frequency=$((frequency * 1.0 / max_frequency))
#         normalized_offset=$((1 - offsets[$file] * 1.0 / max_offset))
# 
#         score=$((frequency_weight * normalized_frequency + (1 - frequency_weight) * normalized_offset))
#     fi
# 
#     scores[$file]=$score
#     # echo "File: $file, frequency: $normalized_frequency, offset: $normalized_offset, score: $score"
#     # echo "File: $file, offset: $normalized_offset"
# done
# 
# combined=()
# for k v ("${(@kv)scores}") combined+=("$v $k\n")
# # echo $combined | sort -r
# echo ' '$combined | sort -k 1,1nr -k 2,2 | grep -v '^$' | cut -d ' ' -f3 | tr '\n' ' '


# keys_sorted_by_decreasing_value=("${${(@On)combined}#*$'\0'}")
# keys_of_the_top_two_values=("${(@)keys_sorted_by_decreasing_value[1,2]}")
# 
# for file in $keys_sorted_by_decreasing_value; do
#     echo $file
# done

# sorted_files=("${(@k)scores}")
# 
# for file in $sorted_files; do
#     echo "File: $file, score: $scores[$file]"
# done

#!/bin/zsh

# Initialize an associative array to store file frequencies
# typeset -A file_freq

# Path to your Zsh history file
# history_file=~/.zsh_history

# # Iterate through the history file and count file occurrences
# while read -r -u 9 line; do
#   # Use a regex to extract file paths (change the regex as needed)
#   # This example extracts any strings starting with '/' and containing a '.' (assumes it's a file)
#   for match in ${(s[/])line//[^/]*.(.*?)\s*|[^/]*}
#   do
#     # Increment the frequency count for each file
#     file_freq[$match]=$((file_freq[$match] + 1))
#   done
# done 9< $history_file
# 
# # Iterate through the associative array and print file frequencies
# for file in ${(ok)file_freq}; do
#   echo "File: $file, Frequency: $file_freq[$file]"
# done
