#!/bin/sh

source $FOX_ROOT/common/utils.sh
source $FOX_ROOT/common/config.sh

function check_dependency() {
    local target=$1
    echo "[fox] checking $target..."
    brew list $target >& /dev/null
}

function install_dependency() {
    local target=$1
    echo "[fox] installing $target..."
    brew install $target > /dev/null
}

# 安装 FOX 所需的依赖
function register_fox_dependency() {
    echo "[fox] start installing system dependencies..."
    # Installing gnu-getopt
    local GGETOPT="/usr/local/bin/ggetopt"
    if [[ ! -x $GGETOPT ]]; then
        (check_dependency gnu-getopt) || (install_dependency gnu-getopt)
        local GNU_GETOPT=`brew list gnu-getopt | grep "bin"`
        if [[ `arch` == "arm64" ]]; then
            sudo ln -s $GNU_GETOPT $GGETOPT
        else 
            ln -s $GNU_GETOPT $GGETOPT
        fi
    fi

    # Installing yq
    (check_dependency yq) || (install_dependency yq)

    # Read brewspec.yaml to install custom dependencies
    local brewspecFile="$FOX_CONFIG/brewspec.yaml"
    local count=`brewspec_value_of dependencies | wc -l | tr -d ' '`
    if [[ -z $count || $count -lt 1 ]]; then
        echo "[fox] \`$FOX_CONFIG/brewspec.yaml\` did not define any brew dependency."
    else
        echo "[fox] start installing brew dependencies..."
        local items=(`brewspec_value_of dependencies | sed "s/^- //" | tr "\n" " "`)
        for item in $items; do
            (check_dependency $item) || (install_dependency $item)
        done
    fi
}

function unregister_fox_dependency() {
    local GGETOPT="/usr/local/bin/ggetopt"
    if [[ -x $GGETOPT ]]; then
        rm $GGETOPT
    fi
}