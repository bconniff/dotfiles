(( $+commands[apt] )) || return 0

function whose {
    (( $# != 1 )) && print "usage: whose [file]" >&2 && return 1
    declare file=$1

    if [[ ! -f $file ]]; then
        file=$(whence $file 2>/dev/null) || return 1
    fi

    file=$(realpath $file)

    dpkg -S $file
}

function apt {
    local -a needs_sudo=(
        install reinstall remove purge autoremove autopurge
        update upgrade full-upgrade dist-upgrade satisfy
        clean autoclean edit-sources
    )

    if (( EUID !=0 && ${needs_sudo[(Ie)$1]} )); then
        sudo apt $@
        return $?
    fi

    command apt $@
}
