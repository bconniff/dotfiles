# vim: set ft=zsh:

setopt prompt_subst

function __prompt__is_ssh {
  which pstree >/dev/null 2>&1 && pstree -s $$ | grep -qE '\bsshd\b'>/dev/null 2>&1
}

function __prompt__ssh_status {
  if __prompt__is_ssh; then
    echo "%B%F{yellow}@$(hostname -s) "
  fi
}

function __prompt__git_status {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    declare branch
    if ! branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
      branch='(init)'
    fi

    if [[ "$branch" = HEAD ]]; then
      branch="(`git rev-parse HEAD | head -c6`)"
    fi

    local -i staged=0 unstaged=0 unknown=0 conflicted=0

    git status --no-renames --porcelain=v1 2>/dev/null | cut -c-2 | while IFS='' read -r line; do
      local stat="${line:0:2}"
      case "$stat" in
        DD|AA|U?|?U) conflicted=$((conflicted + 1)) && continue ;;
        \?\?) unknown=$((unknown + 1)) && continue ;;
      esac

      case "$stat" in
        A?|M?|D?) staged=$((staged + 1 )) ;;
      esac

      case "$stat" in
        ?M|?D) unstaged=$((unstaged + 1)) ;;
      esac
    done

    local -i ahead=0 behind=0
    local upstream

    if upstream=$(git rev-parse @{u} 2>/dev/null); then
      ahead=$(git rev-list --right-only --count @{u}.. 2>/dev/null)
      behind=$(git rev-list --right-only --count ..@{u} 2>/dev/null)
    fi

    local prompt=''

    [[ $branch ]] && prompt="$prompt %B%F{white}$branch%f%b"
    (( $staged )) && prompt="$prompt %B%F{green}$staged+%f%b"
    (( $unstaged )) && prompt="$prompt %B%F{red}$unstaged*%f%b"
    (( $unknown )) && prompt="$prompt %B%F{black}$unknown?%f%b"
    (( $conflicted )) && prompt="$prompt %B%F{magenta}$conflicted×%f%b"

    if [[ $upstream ]]; then
      if (( $ahead && $behind )); then
        prompt="$prompt %B%F{cyan}(DIVERGED)%f%b"
      elif (( $ahead )); then
        prompt="$prompt %B%F{cyan}(push)%f%b"
      elif (( $behind )); then
        prompt="$prompt %B%F{cyan}(pull)%f%b"
      fi
    else
      prompt="$prompt %B%F{cyan}(local)%f%b"
    fi

    echo "$prompt"
  fi
}

function __prompt__cwd {
  declare cwd="${PWD#$HOME}"
  declare prefix=""

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    declare toplevel=$(git rev-parse --show-toplevel)
    prefix="${toplevel##*/}"
    cwd="${PWD#$toplevel}"
  else
    [[ "$cwd" = "$PWD" ]] || prefix="~"
  fi

  declare short=$(echo "$cwd" | sed -E 's!([.]?[^/])[^/]*/!\1/!g')
  echo "$prefix$short"
}

function __prompt__error_code {
  local e=$?
  (( $e )) && echo "%B%F{red}$e "
}

function __prompt__user {
  integer uid=$(id -u)
  if (( $UID )); then
    echo "%B%F{green}%n"
  else
    echo "%B%F{red}%n"
  fi
}

function __prompt__sigil {
  integer e=$?
  if (( $e )); then
    echo "%B%F{red}*"
  elif __prompt__is_ssh; then
    echo "%B%F{yellow}-"
  elif (( $UID )); then
    echo "%B%F{black}%%"
  else
    echo "%B%F{red}#"
  fi
}

function precmd {
  print -rP $'\n''$(__prompt__error_code)$(__prompt__ssh_status)$(__prompt__user) %F{blue}$(__prompt__cwd)%f$(__prompt__git_status)%b%f'
}

PROMPT='$(__prompt__sigil)%b%f '
PS2='%F{black}%B>%f '

# Enable highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Override highlighter colors
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009,underline
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=105
ZSH_HIGHLIGHT_STYLES[alias]=fg=045
ZSH_HIGHLIGHT_STYLES[builtin]=fg=147
ZSH_HIGHLIGHT_STYLES[function]=fg=045
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=243
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=214
ZSH_HIGHLIGHT_STYLES[globbing]=fg=129
ZSH_HIGHLIGHT_STYLES[redirection]=fg=129
ZSH_HIGHLIGHT_STYLES[named-fd]=fg=129
ZSH_HIGHLIGHT_STYLES[numeric-fd]=fg=129
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=132
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=132
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=130
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=179
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=179
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

less_termcap[md]=${fg_bold[blue]}

LESS='-FRX'
