#!/usr/bin/zsh

export BORG_REPO="~/.backup/borg"

__BB_TARGETS=(
    "$(dirname $0)/bb-config.zsh"
)
