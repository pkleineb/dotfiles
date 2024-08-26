# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
#ZSH=/usr/share/oh-my-zsh/

# List of plugins used
plugins=(
	git
	sudo
	zsh-256color
	zsh-autosuggestions
	zsh-syntax-highlighting
    direnv
)
#source $ZSH/oh-my-zsh.sh

# In case a command is not found, try to find the package that has it
#function command_not_found_handler {
#    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
#    printf 'zsh: command not found: %s\n' "$1"
#    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
#    if (( ${#entries[@]} )) ; then
#        printf "${bright}$1${reset} may be found in the following packages:\n"
#        local pkg
#        for entry in "${entries[@]}" ; do
#            local fields=( ${(0)entry} )
#            if [[ "$pkg" != "${fields[2]}" ]] ; then
#                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
#            fi
#            printf '    /%s\n' "${fields[4]}"
#            pkg="${fields[2]}"
#        done
#    fi
#    return 127
#}

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias nv='nvim'
alias lg='lazygit'
alias sysstart='sudo systemctl start'
alias sysstop='sudo systemctl stop'

# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
#alias ssh='kitten ssh' <- this shit created an error and did not fix anything

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
