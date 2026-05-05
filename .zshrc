# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Launch fish if available and not already running
if command -v fish &> /dev/null && ps -p $PPID -o comm= | grep -qv 'fish' && [[ ${SHLVL} == [1,2] ]]; then
	[[ -o login ]] && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi

# Zsh-specific settings (only reached if fish isn't launched)
PS1='[%n@%m %1~]$ '
