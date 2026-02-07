# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Launch fish if available and not already running
if command -v fish &> /dev/null && grep -qv 'fish' /proc/$PPID/comm && [[ ${SHLVL} == [1,2] ]]; then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi

# Bash-specific settings (only reached if fish isn't launched)
PS1='[\u@\h \W]\$ '
