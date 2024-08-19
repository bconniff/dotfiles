set -o vi
bindkey -v

# allow vv to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M visual v edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r and ctrl-s to search the history
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

function zle-line-init zle-keymap-select {
  case "$KEYMAP" in
    vicmd)
      RPS1="%B%F{black}•%f"
      echo -ne '\e[2 q'
    ;;
    main|viins)
      RPS1="%F{yellow}I%f"
      echo -ne '\e[6 q'
    ;;
  esac
  RPS2=$RPS1
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

KEYTIMEOUT=1
