# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

export UPDATE_ZSH_DAYS=30

plugins=(
  git docker docker-compose gradle sudo virtualenv
)

source $ZSH/oh-my-zsh.sh

PROMPT='%(!.%{%F{yellow}%}.)$USER@%{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# misc
alias ex="xdg-open"
alias xclip="xclip -selection c"
alias untar="tar xzf"
alias curls="curl -s -o /dev/null -w '%{http_code}'"
alias serve="python3 -m http.server"
alias winit="sudo stat /proc/1/exe"
alias gf="gitfiend . &"
alias tssh="ssh -T git@github.com"
alias lssh="ls -lSh"

# typos
alias gti="git"

# docker
alias dp="docker ps"
function de { docker exec -it $1 /bin/bash }

# development
alias grun="gradle bootRun"
alias gnrun="gradle --no-daemon bootRun"
alias db="dotnet build"
alias dr="dotnet run"
alias dt="dotnet test"

alias clean-python="rm -rf **/.pytest_cache; rm -rf **/.venv; rm -rf **/.buildvenv; rm -rf **/__pycache__; rm -rf **/.pyc"

# delete local git branches which don't have a tracking branch anymore
# manual step in between to be able to remove branches which should be kept
# https://stackoverflow.com/a/28464339
alias remove-local-branches="git branch --merged >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches"
alias grepdiff="git diff $1 -G $2"
function gir { git check-ignore -v $1 }

# allows for "CORS" requests to file:// (https://stackoverflow.com/a/18147161)
alias chrome-dev="chromium --allow-file-access-from-files"

# HSTR config
if type hstr > /dev/null; then
  alias hh=hstr                     # hh to be alias for hstr
  export HISTFILE=~/.zsh_history    # ensure history file visibility
  export HSTR_CONFIG=hicolor        # get more colors
  bindkey -s "\C-r" "\eqhstr\n"     # bind hstr to Ctrl-r (for Vi mode check doc)
fi

alias ltop="lazydocker"

###
# custom functions
###

# misc
# custom delimiter, because I occasionally replace paths...
# https://www.unix.com/302211291-post2.html?s=c643e85d891ee4c88e3ba954f81fd348
function repl { find ${3:-.} -type f -print0 | xargs -0 sed -i -e 's,'$1','$2',' }

# convert video to different resolution, e.g. `scale_video input_video.mp4 480:270 output.mp4
function scale_video { ffmpeg -i $1 -vf scale=$2 $3 -hide_banner }

# pass all $1 to $2, e.g. 'build.gradle' and 'code' means, open all build.gradle with code
function execonfile { find . -name "$1" -exec $2 {} \+ }

# count lines in files with specific ending, e.g. countlines java
function countlines { find ${2:-.} -type f -name "*.$1" -exec wc -l {} + | sort -n }
# count lines in files with specific ending, but omit test classes, e.g. countlinesnotest cs
function countlinesnotest { find ${2:-.} -type f -name "*.$1" -not -name "*Test.$1" -exec wc -l {} + | sort -n }

# network
function portf { lsof -i:$1 }
function portff { ss | grep $1 }

function addip { ip addr add $1/24 dev $2 }
function delip { ip addr del $1/24 dev $2 }

function up { ip link set up dev $1 }
function down { ip link set down dev $1 }

# find ip addresses in the given network ($1 = X.X.X.0)
function nwscan { nmap -sP $1/24 }

# examine code bases
function grepj { grep -r --include \*.java --exclude-dir test "$1" ${2:-.} }
function findj { find . -name "$1.java" }

function grepcs { grep -r --include \*.cs --exclude "*.Test" "$1" ${2:-.} }
function findcs { find . -name "$1.cs" }

function grepkt { grep -r --include \*.kt --exclude-dir test "$1" ${2:-.} }
function findkt { find . -name "$1.kt" }

# docker
# remove containers by (exact) *image* name
function drm { docker rm $(docker ps -a -q --filter ancestor=$1) }
function drmf { docker rm -f $(docker ps -a -q --filter ancestor=$1) }

# fun
# use numblock LED 3 for ping feedback @climagic
function lping {  ping $1 | stdbuf -oL awk -F"[=\ ]" '/from/{ms=$(NF-1); print ms/1000.0 " " 1-ms/1000.0}' | while read on off ; do echo $on $off ; xset led 3 ; sleep $on ; xset -led 3 ; sleep $off ; done }

# allow docker X11 forwarding to host
if type xhost > /dev/null; then
  xhost local:root
fi

# make CTRL+U work to delete everything left from the cursor in ZSH
bindkey \^U backward-kill-line

# make use of zsh's REPORTTIME https://nuclearsquid.com/writings/reporttime-in-zsh/
export REPORTTIME=5

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    timer_show=$(printf '%.*f\n' 0 $timer_show)
    unset timer
  else
    timer_show='-'
  fi
}

# patch the default dircolors to have black as background for otherwise unreadable
# OTHER_WRITEABLE: https://unix.stackexchange.com/a/94508
if [[ -f ~/.dircolors ]] ; then
    eval $(dircolors -b ~/.dircolors)     
elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
fi

function preexec() {
  timer=$SECONDS
}

function precmd() {
  if [[ -n $timer ]]; then
    timer_show=$(( SECONDS - timer ))
    unset timer
  else
    timer_show='-'
  fi
}

RPS1='[%?] : took ${timer_show}s'

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
if command -v fzf >/dev/null 2>&1; then
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    # Debian/Ubuntu fallback
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi
fi

# highlight stderr output
#exec 2>>(while read line; do print '\e[45m[☇ stderr]\e[0m '${(q)line}'' > /dev/tty; print -n $'\0'; done &)

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
