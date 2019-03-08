user="%n"
host="%m"
directory="%~"
short_directory="%c"
PROMPT='%{$fg[white]%}$user@$host (%D %*) %{$fg_bold[white]%}➜ %{$bg_bold[cyan]%}$directory%{$reset_color%} %{$fg_bold[white]%}$(git_prompt_info)
%{$fg_bold[cyan]%}$ % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
