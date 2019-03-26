# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mn/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mn"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git docker docker-compose gradle
)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

alias ex="xdg-open"

alias dp="docker ps"
alias de="docker exec -it"

alias gti="git"

alias grun="gradle bootRun"
alias gnrun="gradle --no-daemon bootRun"

alias db="dotnet build"
alias dr="dotnet run"
alias dt="dotnet test"

alias curls="curl -s -o /dev/null -w '%{http_code}'"

function portf { lsof -i:$1 }
function portff { ss | grep $1 }

function grepj { grep -r --include \*.java --exclude-dir test "$1" ${2:-.} }
function findj { find . -name "$1.java" }

function grepcs { grep -r --include \*.cs --exclude "*.Test" "$1" ${2:-.} }
function findcs { find . -name "$1.cs" }

# custom delimiter, because I occasionally replace paths...
# https://www.unix.com/302211291-post2.html?s=c643e85d891ee4c88e3ba954f81fd348
function repl { find ${3:-.} -type f -print0 | xargs -0 sed -i -e 's,'$1','$2',' }

# pass all $1 to $2, e.g. 'build.gradle' and 'code' means, open all build.gradle with code
function execonfile { find . -name "$1" -exec $2 {} \+ }

# count lines in files with specific ending, e.g. countlines java
function countlines { find ${2:-.} -type f -name "*.$1" -exec wc -l {} + | sort -n }
# count lines in files with specific ending, but omit test classes, e.g. countlinesnotest cs
function countlinesnotest { find ${2:-.} -type f -name "*.$1" -not -name "*Test.$1" -exec wc -l {} + | sort -n }

alias untar="tar xzf"

xhost local:root
