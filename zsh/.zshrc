# autoloads
autoload colors && colors
autoload -Uz compinit && compinit

# plugins
declare -a plugins=(
    ~/.zsh/plugins/vi-mode/vi-mode.zsh
    ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ~/.zsh/plugins/p/p.zsh
    ~/.zsh/plugins/fzf/fzf.zsh
    ~/.zsh/plugins/history/history.zsh
)

for x in $plugins; do
    [[ -f $x ]] && . $x
done

# theme
. ~/.zsh/themes/nox.zsh-theme

# aliases
alias grep='grep --color'
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias agi='ag -i'
alias agil='ag -il'
alias agio='agi --noheading --nofilename --nonumber --nobreak -o'
alias ta='tmux a || tmux'

# local config, if available
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
