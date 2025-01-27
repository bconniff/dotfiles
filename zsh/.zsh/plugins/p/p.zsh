function p {
    if [[ $1 ]]; then
        [[ -d ~/Code/$1 ]] && cd ~/Code/$1
    else
        declare toplevel
        if toplevel=`git rev-parse --show-toplevel 2>/dev/null`; then
            cd $toplevel
        else
            cd
        fi
    fi
}

function _p {
    declare -a opts=()
    if [[ -d ~/Code ]]; then
        for x in ~/Code/*; do
            [[ -d $x ]] && opts+=(${x##*/})
        done
    fi
    compadd ${opts[@]}
}

compdef _p p
