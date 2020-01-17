#!/usr/bin/zsh

__BB_LOCAL_DIR="$(dirname $0)/";
__BB_CONFIG_TEMPLATE="${__BB_LOCAL_DIR}/borgbackup.config.template";
__BB_CONFIG_FILE="${HOME}/.config/bb-zsh/borgbackup.config.zsh";

# if not e, if naugthy..
if [[ ! -e "$__BB_CONFIG_FILE" ]]; then
    # make a config under .config/bb-zsh
    mkdir -p `dirname ${__BB_CONFIG_FILE}`;
    cp ${__BB_CONFIG_TEMPLATE} ${__BB_CONFIG_FILE};
fi

source "$__BB_CONFIG_FILE";

# set and make BORG_REPO (but doesn't init it)
__BB_STORE="${__BB_BACKUP_DIR}/${HOSTNAME}"
export BORG_REPO="${__BB_STORE}/borg"
[[ -e $BORG_REPO ]]  || mkdir -p $BORG_REPO || return 1;

function __bb_help() {
    echo -e "Usage: bb [OPTION]";
    
    echo -e "\nOptions:"
    
    echo -e "    help, -h, --help \t\t show this help menu"
    
    echo -e "    backup, -b, --backup \t perform a backup. The same can be achieved
    \t\t\t\t by typing 'bb' without any args"
    
    echo -e "    edit, -e, --edit \t\t edit the config file, add targets and/or options"
    
    echo -e "\nExamples:"
    echo -e "    bb"
    echo -e "    bb edit"
    echo -e ""
}

__bb_archive() {
    local archive_name="${HOSTNAME}.tar.gz"
    local store_name=${HOSTNAME};
    (
        cd ${__BB_BACKUP_DIR};
        
        # shred old archive
        [[ -e ${archive_name} ]] && echo "shredding old archive: ${archive_name}.." && shred -un 1 ${archive_name};
        
        # create new archive
        echo "creating new archive: ${archive_name}.." && tar --gzip --create --file=${archive_name} ${store_name} && \
        # print file size
        echo archive created @ $((`stat -c %s ${archive_name}`/(1024*1024)))MB
    )
}

function __bb_backup() {
    source $__BB_CONFIG_FILE; # because it's a script, and stale state between shells can occur
    borg "${__BB_OPTIONS[@]}" create "${BORG_REPO}"::"$__BB_ARCHIVE_NAME" "${__BB_TARGETS[@]}" && \
    ([[ $__SHOULD_ARCHIVE == true ]] && __bb_archive)
}

function __bb_edit() {
    if [[ -z $EDITOR ]]; then
        vim $__BB_CONFIG_FILE;
    else
        $EDITOR $__BB_CONFIG_FILE;
    fi
}

function bb() {
    [[ -z `command -v borg` ]] && echo "you must install borgbackup first" && return 1;
    [[ -z $__BB_BACKUP_DIR ]] && echo "you must set __BB_BACKUP_DIR in the config file - use 'bb edit'" && return 1;
    [[ -z $__SHOULD_ARCHIVE ]] && echo "you must set __SHOULD_ARCHIVE in the config file - use 'bb edit'" && return 1;
    
    case "$1" in
        ""|"backup"|"-b"|"--backup")
            __bb_backup;
        ;;
        "edit"|"-e"|"--edit")
            __bb_edit;
        ;;
        "help"|"-h"|"--help")
            __bb_help;
        ;;
        *)
            echo "bb: invalid option -- '${1}'"
            echo "Try 'bb help' for more information."
        ;;
    esac
}
