#!/bin/sh

source $FOX_ROOT/common/utils.sh

function _usage_of_fox() {
    cat << EOF
Usage:
    fox subcmd1 [subcmd2] [-option] [value] ...

Description:
    使用 Tab 提示，选择对应的子命令，从而索引到指定的脚本。使用选项/参数为脚本提供运行参数。

Option:
    --help|-h:                                                  -- 使用帮助
    --debug|-x:                                                 -- 使用帮助

EOF
}

function _search_and_execut_script() {
    local path="$FOX_SCRIPTS"
    while [[ ! -z $1 && ! $1 =~ ^- ]]; do
        path="$path/$1"
        shift 1
    done
    local script="$path.sh"
    if [[ ! -x $script ]]; then
        error "$script not exist."
        exit 1
    fi
    zsh $script $*
}

function fox() {
    if [[ $# -eq 0 || $1 == "-h" || $1 == "--help" ]]; then
        _usage_of_fox
        exit 1
    fi

    if [[ $1 == "-x" || $1 == "--debug" ]]; then
        set -x
    fi

    _search_and_execut_script $*

    if [[ $1 == "-x" || $1 == "--debug" ]]; then
        set +x
    fi
}

fox $*