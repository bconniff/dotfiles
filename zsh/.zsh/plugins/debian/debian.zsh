(( EUID == 0 )) && return 0
[[ -x /usr/bin/apt ]] || return 0

function apt {
    local -a priv=(
        install reinstall remove purge autoremove autopurge
        update upgrade full-upgrade dist-upgrade satisfy
        clean autoclean edit-sources
    )
    if (( ${priv[(Ie)$1]} )); then
        sudo /usr/bin/apt $@
    else
        /usr/bin/apt $@
    fi
}
