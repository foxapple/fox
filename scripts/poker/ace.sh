#!/bin/sh

##############################################################################
##
##  Filename: ace.sh
##  Author: baocq
##  E-mail: baocq@fenbi.com
##  Date: Sun Nov  8 15:27:20 CST 2020
##
##############################################################################

source $FOX_COMMON/utils.sh
source $FOX_COMMON/config.sh

# Usage of ace.sh
function _usage_of_ace() {
    cat << EOF
Usage:
    ace [--count <count>] [-r]

Description:
    ace 相关功能

Option:
    --help|-h:                                          -- 使用帮助
    --debug|-x:                                         -- 调试模式
    --reverse|-r:                                       -- 是否逆序打印，无改选项则正序打印
    --count|-c:                                         -- 打印次数，无该选项则打印一遍

EOF
}

# getopt 命令格式说明:
#   -o: 表示定义短选项
#       示例解释: ab:c:: 定义了三个选项类型。
#           a 后面未带冒号，表示定义的 a 选项是开关类型(true/false)，不需要额外参数，使用 -a 选项即表示true。
#           b 后面带冒号，表示定义的 b 选项需要额外参数，如: -b 30
#           c 后面带双冒号，表示定义的 c 选项有一个可选参数，可选参数必须紧贴选项，如: -carg 而不能是 -c arg
#   -long: 表示定义长选项
#       示例解释: a-long,b-long:,c-long::。含义与上述基本一致。
#   "$@": 表示参数本身的列表，也不包括命令本身
#   -n: 表示出错时的信息
#   --:
#       如何创建一个 -f 的目录
#       mkdir -f 会执行失败，因为 -f 会被 mkdir 当做选项来解析
#       mkdir -- -f 会执行成功，-f 不会被当做选项

function ace() {
    local debug=0
    local reverse=false
    local count=1

    local ARGS=`ggetopt -o hxrc: --long help,debug,reverse,count: -n 'Error' -- "$@"`
    if [ $? != 0 ]; then
        error "Invalid option..." >&2;
        exit 1;
    fi
    # 重新排列参数的顺序
    eval set -- "$ARGS"
    # 经过 getopt 的处理，下面处理具体选项。
    while true ; do
        case "$1" in
            -h|--help)
                _usage_of_ace
                exit 1
                ;;
            -x|--debug)
                debug=1
                shift
                ;;
            -r|--reverse)
                reverse=true
                shift
                ;;
            -c|--count)
                count=$2
                shift 2
                ;;
            --)
                shift
                break
                ;;
            *)
                error "Internal Error!"
                exit 1
                ;;
        esac
    done

    if [[ $debug == 1 ]]; then
        set -x
    fi

    # start
    local poker=(A 2 3 4 5 6 7 8 9 10 J Q K Joker)
    
    if [[ $reverse == true ]]; then
        local length=${#poker[*]}
        local tmp=($poker)
        local i=0
        while [[ $i -lt $length ]]; do
            poker[$[$i + 1]]=$tmp[$[$length - $i]]
            i=$[i + 1]
        done
    fi

    local j=0
    while [[ $j -lt $count ]]; do
        echo $poker
        j=$[j + 1]
    done

    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
ace $*