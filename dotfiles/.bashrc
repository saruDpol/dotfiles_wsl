# ~/.bashrc
# Check for interactive shell
[[ $- != *i* ]] && return



# export STARSHIP_CONFIG=~/.config/starship.toml
# eval "$($HOME/.local/bin/starship init bash)"
# eval "$(starship init bash)" 
# starship preset tokyo-night -o ~/.config/starship.toml

# ───────────────────────────────
# 🎨 Color Palette
# ───────────────────────────────
SHAOLIN_ORANGE='\[\033[38;5;214m\]'  
JAPANESE_BLUE='\[\033[38;5;32m\]'    
JAPANESE_RED='\[\033[38;5;131m\]'
GOLD='\[\033[38;5;178m\]'            
WHITE='\[\033[38;5;250m\]'           
RESET='\[\033[0m\]'                  

# ───────────────────────────────
# 📂 Directory Navigation Shortcuts
# ───────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias projects="cd ~/projects"
alias windows="cd ~/../../mnt/c/Users/ptorn/"
alias ebash="nvim ~/.bashrc"
alias ubash="source ~/.bashrc"
alias root="cd ~"
alias cl="clear && ll"
alias biosfer="cd ~/../../mnt/c/Users/ptorn/POL/Biosfer/"
alias ls='eza --group-directories-first --icons --color=always'
alias ll='eza -la --git --time-style=long-iso --group-directories-first --icons --color=always --git'
alias lt='eza -T --icons --color=always --group-directories-first'

# zoxide
alias cd="z"
eval "$(zoxide init bash)"

# git helper
git() {
  if [[ "$1" == "rm" ]]; then
    shift
    command git rm --cached "$@"
  else
    command git "$@"
  fi
}

# ───────────────────────────────
# 🏯 Zen-Inspired Bash Prompt
# ───────────────────────────────
# export PS1="\n\
# ${SHAOLIN_ORANGE}╭───╼ ${GOLD}saruDpol ${WHITE}| \D{%Y-%m-%d %H:%M:%S} \n\
# ${JAPANESE_BLUE}╰─► ${WHITE}\w${RESET} \n\$ "
#
# . "$HOME/.local/bin/env"
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ───────────────────────────────
# nvm (Node Version Manager)
# ───────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

eval "$(starship init bash)"
