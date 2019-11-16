#!/usr/bin/zsh

__LOCAL_DIR="$(dirname $0)/"
__BB_CONFIG_FILE="${__LOCAL_DIR}/bb-config.zsh"

source "$__BB_CONFIG_FILE"

function __exit() {
    unset __BB_CONFIG_FILE;
    unset __LOCAL_DIR;
    exit $1
}

function __help() {
    echo "help menu"
}

function __backup() {
    echo "backup"
}

function __set_repo() {
    # $1 is the repo path
    [[ -z $1 ]] && echo "you must provide a repo path" && __exit 1
    sed -i "/^export BORG_REPO=/c\export BORG_REPO=\"${1}\"" "$__BB_CONFIG_FILE"
}

function __add_target() {
    [[ -z $1 ]] && echo "you must provide a target path" && __exit 2
    echo "add target"
}


case "$1" in
    "backup"|"-b"|"--backup")
        __backup;
    ;;
    "add"|"-a"|"--add")
        __add_target;
    ;;
    "setrepo"|"-r"|"--setrepo"|"--set-repo")
        __set_repo $2; # pass in repo path
    ;;
    "help"|"-h"|"--help")
        __help;
    ;;
    *)
        echo "invalid command '$1'";
    ;;
esac

__exit 0