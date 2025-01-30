# plugins
declare -a plugins=(
    ~/.zsh/plugins/vi-mode/vi-mode.zsh
    ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ~/.zsh/plugins/fzf/fzf.zsh
    ~/.zsh/plugins/history/history.zsh
    ~/.zsh/plugins/completion/completion.zsh
)

for x in $plugins; do
    [[ -f $x ]] && source $x
done

# theme
source ~/.zsh/themes/nox.zsh-theme

# aliases
alias grep='grep --color'
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias agi='ag -i'
alias agil='ag -il'
alias agio='agi --noheading --nofilename --nonumber --nobreak -o'
alias ta='tmux a || tmux'

# cdpath
declare -a cdpath=(
    ~/Code
)

# local config, if available
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

