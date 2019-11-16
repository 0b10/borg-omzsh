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

function __bb_set_repo() {
    # $1 is the repo path
    [[ -z $1 ]] && echo "you must provide a repo path" && __exit 1
    sed -i "/^export BORG_REPO=/c\export BORG_REPO=\"${1}\"" "$__BB_CONFIG_FILE"
}

function __bb_add_target() {
    # $1 is the target path to include in backups
    [[ -z $1 ]] && echo "you must provide a target path" && __exit 2
    __BB_TARGETS+=($1)
    for item in "${__BB_TARGETS[@]}"; do
        echo $item
    done;
}


case "$1" in
    "backup"|"-b"|"--backup")
        __bb_backup;
    ;;
    "add"|"-a"|"--add")
        __bb_add_target $2;
    ;;
    "setrepo"|"-r"|"--setrepo"|"--set-repo")
        __bb_set_repo $2; # pass in repo path
    ;;
    "help"|"-h"|"--help")
        __bb_help;
    ;;
    *)
        echo "invalid command '$1'";
    ;;
esac

__exit 0