# Dont share history
setopt share_history
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Firefox Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# Persistent rehash
zstyle ':completion:*' rehash true

# Enable autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable autojump
source /usr/share/autojump/autojump.bash

# Alternate Vim Aliases
alias mvim="nvim -u ~/.config/nvim/minimal.vim"

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Edit line in mvim with ctrl-e:
export VISUAL="nvim -u ~/.config/nvim/minimal.vim -c 'nnoremap q :wq<CR>'"
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

fzf-history() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --height "50%" | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

bindkey -s '^t' '^ufzf-history\n'

setopt histignoredups
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -lah"
alias icat="kitty +kitten icat"
# Alias for wvim, neovim for writing
alias wvim="nvim -u ~/.config/nvim/winit.vim"
alias nivm="nvim"
# Color Alias for ip command
alias ip="ip -c"
alias kssh="kitty +kitten ssh"
#Alt Key Binding
bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word
