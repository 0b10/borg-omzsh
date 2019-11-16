#!/usr/bin/zsh

__BB_LOCAL_DIR="$(dirname $0)/";
__BB_CONFIG_TEMPLATE="${__BB_LOCAL_DIR}/borgbackup.config.template";
__BB_CONFIG_FILE="${HOME}/.config/bb-omzsh/borgbackup.config.zsh";

# if not e, if naugthy..
if [[ ! -e "$__BB_CONFIG_FILE" ]]; then
    # make a config under .config/bb-omzsh
    mkdir -p `dirname ${__BB_CONFIG_FILE}`;
    cp ${__BB_CONFIG_TEMPLATE} ${__BB_CONFIG_FILE};
fi

source "$__BB_CONFIG_FILE";


function __bb_help() {
    echo "help menu";
}

function __bb_backup() {
    borg "${__BB_OPTIONS[@]}" create "${BORG_REPO}"::"$__BB_ARCHIVE_NAME" "${__BB_TARGETS[@]}";
}

function __bb_edit() {
    if [[ -z $EDITOR ]]; then
        $EDITOR $__BB_CONFIG_FILE;
    else
        vim $__BB_CONFIG_FILE;
    fi
}

function bb() {
    [[ -z `command -v borg` ]] && echo "you must install borgbackup first" && return 1;
    [[ -z $BORG_REPO ]] && echo "you must export BORG_REPO from your zshrc first" && return 1;
    
    case "$1" in
        "backup"|"-b"|"--backup")
            __bb_backup;
        ;;
        "edit"|"-e"|"--edit")
            __bb_edit;
        ;;
        "help"|"-h"|"--help")
            __bb_help;
        ;;
        *)
            __bb_backup;
        ;;
    esac
}