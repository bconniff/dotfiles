zmodload zsh/complist
autoload -Uz compinit && compinit

unsetopt menucomplete
unsetopt flowcontrol
unsetopt autoremoveslash

setopt autolist
setopt automenu
setopt completeinword
setopt alwaystoend
setopt autocd

# completion engines
zstyle ':completion:*' completer _extensions _complete _approximate

# use menu selection
zstyle ':completion:*' menu select

# complete . and ..
zstyle ':completion:*' special-dirs true

# processes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# directory completion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack named-directories path-directories

# caching
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zcompcache

# descriptions
zstyle ':completion:*:descriptions' format "%F{black}%B⎯⎯%f %d %F{black}⎯⎯%f%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "%F{red}%BNo matches%f%b"
zstyle ':completion:*:corrections' format "%F{black}%B⎯⎯%F{yellow} %e %d %F{black}⎯⎯%f%b"

# handle escape key in menu
bindkey -M menuselect -s '\e' '^M\e'
