# ~/.bash_profile
export PATH="$HOME/.local/bin:$PATH"

# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Terminal title (current directory)
case $TERM in
xterm*|rxvt*|gnome-terminal*|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
    ;;
esac

# Source any local environment scripts
. "$HOME/.local/bin/env"

# ---- Starship must be the last thing ----
eval "$(starship init bash)"
