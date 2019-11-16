#!/usr/bin/zsh

LOCAL_DIR="$(dirname $0)/"
BB_CONFIG_FILE="${LOCAL_DIR}/bb-config.zsh"

source "$BB_CONFIG_FILE"

function __help() {
    echo "help menu"
}

function __backup() {
    echo "backup"
}

function __set_repo() {
    # $1 is the repo path
    sed -i "/^export BORG_REPO=/c\export BORG_REPO=\"${1}\"" "$BB_CONFIG_FILE"
}

case "$1" in
    "backup"|"-b"|"--backup")
        __backup;
    ;;
    "setrepo"|"-r"|"--setrepo"|"--set-repo")
        [[ -z $2 ]] && echo "you must provide a repo path" && return 1
        __set_repo $2; # pass in repo path
    ;;
    "help"|"-h"|"--help")
        __help;
    ;;
    *)
        echo "invalid command '$1'";
    ;;
esac

unset BB_CONFIG_FILE;