#!/usr/bin/zsh

export BORG_REPO="${HOME}/.backup/borg"

__BB_TARGETS=(
    "$(dirname $0)/bb-config.zsh"
)

__BB_ARCHIVE_NAME="borgbackup-{hostname}-{now}"

__BB_OPTIONS=(
    "--info"
    "--progress"
)