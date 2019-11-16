#!/usr/bin/zsh

BB_CONFIG_FILE="./bb-config.zsh"

source "$BB_CONFIG_FILE"

function __help() {
    echo "help menu"
}

function __backup() {
    echo "backup"
}

function __set_repo() {
    echo "setting repo"
}

case "$1" in
    "backup"|"-b"|"--backup")
        __backup;
    ;;
    "setrepo"|"-r"|"--setrepo"|"--set-repo")
        __set_repo;
    ;;
    "help"|"-h"|"--help")
        __help;
    ;;
    *)
        echo "invalid command '$1'";
    ;;
esac

unset BB_CONFIG_FILE;