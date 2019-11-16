#!/usr/bin/zsh

function __help() {
    echo "help menu"
}

function __backup() {
    echo "backup"
}

case "$1" in
    "backup"|"-b"|"--backup")
        __backup
    ;;
    "help"|"-h"|"--help")
        __help
    ;;
    *)
        echo "invalid command '$1'";
    ;;
esac