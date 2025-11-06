# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="dd-mm-yyyy"
HIST_STAMPS="%d-%m-%y %T"
#

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
# plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)
plugins=(zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
# plugins=(git zsh-autosuggestions)
# plugins=(git zsh-syntax-highlighting zsh-autocomplete)
# plugins=(git zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

if test "$(lsmod | grep pcspkr)"; then
    sudo rmmod pcspkr
fi

# options

unsetopt AUTO_REMOVE_SLASH # do not remove slash after directory name when typing word separator

# widgets

backward-delete-path-component() {
  local cursor_position=$CURSOR

  if [[ "$BUFFER" == */* ]]; then
    local prefix=${BUFFER[1,cursor_position]}

    if [[ "${prefix[-1]}" == "/" ]]; then
      prefix="$(echo "$prefix" | sed -E 's#(/|[ \t]*)[^/ \t]*/$#\1#')"
    else
      prefix="$(echo "$prefix" | sed -E 's#(/|[ \t]*)[^/ \t]*$#\1#')"
    fi

    local suffix=${BUFFER[cursor_position+1,-1]}

    BUFFER="$prefix$suffix"
    CURSOR=${#prefix}
  else
    # Exhibit the default Ctrl+W behavior (delete the last word)
    zle backward-kill-word
  fi
}

# syntax highlighting customization for zsh-syntax-highlighting

if [ ! -z "$ZSH_HIGHLIGHT_STYLES" ]; then
    ZSH_HIGHLIGHT_STYLES[path]='fg=009'

    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=099'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=080'

    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=117'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=169'

    for key val in "${(@kv)ZSH_HIGHLIGHT_STYLES}"; do # make all styles bold
        if [[ ! "$val" == *"bold"* ]]; then
            if [[ -z "$val" ]] || [[ "$val" == 'none' ]]; then
                ZSH_HIGHLIGHT_STYLES[$key]='bold'
            else
                ZSH_HIGHLIGHT_STYLES[$key]="$val,bold"
            fi
        fi
    done
fi

# Key bindings

bindkey "^I" menu-complete # continue path expansion to nested directories

zle -N backward-delete-path-component # delete last path component on ctrl + W
bindkey '^W' backward-delete-path-component

# bindkey -M menuselect '^\r' .accept-line
# bindkey -M menuselect '^M' .accept-line
# bindkey -M menuselect '^[f' .accept-line
# bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select # cycle through menu to autocomplete on tab
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

bindkey -M menuselect '^[' undo # stop cycling on esc
KEYTIMEOUT=10

# etc

hello () {
    echo $1
}

# _CONDA_ENVS="$(conda env list | grep -v '^#' | cut -d ' ' -f 1 | head -n -1 | tr '\n' ' ')"

_hello () {
    compadd foo bar baz
    # eval "compadd $_CONDA_ENVS"
    # compadd $(conda env list | grep -v '^#' | cut -d ' ' -f 1 | head -n -1)
}

compdef _hello hello

_python_modules_() {
    if [ ${#words[@]} -le 4 ]; then
        if [[ $words[2] == "-m" ]]; then
            local module_name="$words[3]"

            if [ ! -z "$module_name" ]; then
                if [ -f "$module_name/__main__.py" ]; then
                    local completions_="$(cat $module_name/__main__.py | grep '^def' | sed -E 's/def\s([^\(]+)\(.*/\1/' | sed 's/_/-/g' | tr '\n' ' ')"
                    local completions=(${(@s: :)completions_})

                    _describe 'commands' completions
                else
                    _python_modules
                fi
            else
                _python_modules
            fi
        fi
    else
        _files
    fi
}

compdef _python_modules_ 'python'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

try_source () {
    filename=${2:-.bashrc}
    script_path="$HOME/$1/$filename"

    if test -f "$script_path"; then
        . "$script_path"
    fi
}

if test -f "$HOME/bashrc/local.sh"; then
  . "$HOME/bashrc/local.sh"
fi

try_source colorful-prompt colorful-prompt.sh
try_source kubetools
try_source git-tools
try_source shell # self-import

try_source docker-tools aliases.sh
try_source curl-tools
try_source paste-token aliases.sh

try_source smash .zshrc

try_source new main.sh
try_source cvesna

# function preexec() {
#   echo 'foo'
#   timer=$(($(date +%s%0N)/1000000))
# }
# 
# function precmd() {
#   if [ $timer ]; then
#     now=$(($(date +%s%0N)/1000000))
#     elapsed=$(($now-$timer))
# 
#     export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
#     unset timer
#   fi
# }

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# bindkey -M menuselect '^[OP' .accept-line
# bindkey -M menuselect '^[[[CE' .accept-line

# bindkey '^[[[CE' .accept-line
bindkey '^[[[CE' accept-line
bindkey -M menuselect '^M' .accept-line

# setopt no_share_history
# unsetopt share_history

alias chrome="google-chrome-stable --disable-features=DownloadBubble"

try_source shell ee.zsh
# try_source shell ls.zsh

unsetopt correct_all
