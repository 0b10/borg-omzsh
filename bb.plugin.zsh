#!/usr/bin/zsh

[[ -z $BORG_REPO ]] && echo "you must export BORG_REPO from your zshrc first" && return 1

__BB_LOCAL_DIR="$(dirname $0)/"
__BB_CONFIG_FILE="${__BB_LOCAL_DIR}/bb-config.zsh"

source "$__BB_CONFIG_FILE"

function __bb_help() {
    echo "help menu"
}

function __bb_backup() {
    borg "${__BB_OPTIONS[@]}" create "${BORG_REPO}"::"$__BB_ARCHIVE_NAME" "${__BB_TARGETS[@]}"
}

function __bb_edit() {
    if [[ -z $EDITOR ]]; then
        $EDITOR $__BB_CONFIG_FILE;
    else
        vim $__BB_CONFIG_FILE;
    fi
}

case "$1" in
    "backup"|"-b"|"--backup")
        __bb_backup;
    ;;
    "edit"|"-e"|"--edit")
        __bb_edit
    ;;
    "help"|"-h"|"--help")
        __bb_help;
    ;;
    *)
        echo "invalid command '$1'";
    ;;
esac