#
#

export __PROFILE_PROMPT_DIR=$ZSH/custom/plugins/switcher

setopt PROMPT_SUBST

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

preexec_functions+='preexec_update_profile_name'
precmd_functions+='precmd_update_profile_name'
chpwd_functions+='chpwd_update_profile_name'

function preexec_update_profile_name() {
    case "$2" in
        persona*)
        __EXECUTED_PROFILE_COMMAND=1
        ;;
    esac
}
function precmd_update_profile_name() {
    if [ -n "$__EXECUTED_PROFILE_COMMAND" ]; then
        update_current_profile
        unset __EXECUTED_PROFILE_COMMAND
    fi
}

function chpwd_update_profile_name() {
    update_current_profile
}

function update_current_profile() {
    unset __PROFILE_NAME

    local profilestatus="$__PROFILE_PROMPT_DIR/profile.php"
    _PROFILE_STATUS=`php ${profilestatus}`
    __PROFILE_NAME=("${(f)_PROFILE_STATUS}")
}

function get_profile() {
   if [ -n "$__PROFILE_NAME" ]; then
       echo "%{${fg[red]}%}$__PROFILE_NAME%{${fg[default]}%}"
   fi
}

RPROMPT='$(get_profile)'
