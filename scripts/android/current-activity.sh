#!/bin/sh

##############################################################################
##
##  Filename: current-activity.sh
##  Author: lizhe
##  E-mail: lizhe@fenbi.com
##  Date: 2021年 2月 9日 星期二 18时33分39秒 CST
##
##############################################################################

source $NOX_COMMON/utils.sh
source $NOX_COMMON/config.sh

# Usage of current-activity.sh
function _usage_of_current_activity() {
    cat << EOF
Usage:
    current-activity

Description:
    查看顶层 activity 是什么

Option:
    --help|-h:                                          -- 使用帮助
    --debug|-x:                                         -- 调试模式

EOF
}

# getopt 命令格式说明:
#   --options: 表示定义短选项
#       示例解释: ab:c:: 定义了三个选项类型。
#           a 后面未带冒号，表示定义的 a 选项是开关类型(true/false)，不需要额外参数，使用 -a 选项即表示true。
#           b 后面带冒号，表示定义的 b 选项需要额外参数，如: -b 30
#           c 后面带双冒号，表示定义的 c 选项有一个可选参数，可选参数必须紧贴选项，如: -carg 而不能是 -c arg
#   --longoptions: 表示定义长选项
#       示例解释: a-long,b-long:,c-long::。含义与上述基本一致。
#   "$@": 表示参数本身的列表，也不包括命令本身
#   -n: 表示出错时的信息
#   --:
#       如何创建一个 -f 的目录
#       mkdir -f 会执行失败，因为 -f 会被 mkdir 当做选项来解析
#       mkdir -- -f 会执行成功，-f 不会被当做选项

function current_activity() {
    local debug=0

    local ARGS=`ggetopt --options hx --longoptions help,debug -n 'Error' -- "$@"`
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
                _usage_of_current_activity
                exit 1
                ;;
            -x|--debug)
                debug=1
                shift
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
    adb shell dumpsys activity top | grep ACTIVITY | grep fenbi


    if [[ $debug == 1 ]]; then
        set +x
    fi
}

# Execute current script
current_activity $*
