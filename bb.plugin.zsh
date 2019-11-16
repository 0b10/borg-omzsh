#!/usr/bin/zsh

__BB_LOCAL_DIR="$(dirname $0)/"
__BB_CONFIG_FILE="${__BB_LOCAL_DIR}/bb-config.zsh"

source "$__BB_CONFIG_FILE"

function __exit() {
    unset __BB_CONFIG_FILE;
    unset __BB_LOCAL_DIR;
    unset __BB_TARGET;
    exit $1
}

function __bb_help() {
    echo "help menu"
}

function __bb_backup() {
    echo "backup"
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

__exit 0