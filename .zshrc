# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^R' history-incremental-search-backward

bindkey -v
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Vi style:
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -v '^?' backward-delete-char



#alias ll="ls -lahG"
alias ll="exa -lh --color=always --group-directories-first"
alias cat="bat"
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias k=kubectl
export do="-o yaml --dry-run=client "
export EDITOR=vim

#PROMPT='%B%F{75}%1~%f%b %# '
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/Users/ray/.local/bin:/usr/local/opt/openssl@3/bin:$PATH"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
eval "$(pyenv init -)"


source /Users/ray/.config/broot/launcher/bash/br
