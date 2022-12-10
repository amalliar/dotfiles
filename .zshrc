zstyle :compinstall filename '/home/amalliar/.zshrc'

# Configure zsh history cache parameters.
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.histfile

# Treat the `#', `~' and `^' characters as part of patterns for filename
# generation, etc.
setopt extendedglob

# If a pattern for filename generation has no matches, print an error, instead
# of leaving it unchanged in the argument list.
setopt nomatch

# Enhanced auto completion.
autoload -Uz compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Use vi-style key bindings.
bindkey -v

# Use vim keys in tab complete menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # Initiate `vi insert` as keymap.
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Close the shell even if the command line is filled.
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Automaticaly cd to current dir on ranger exit.
ranger_cd() {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}
bindkey -s '^O' 'ranger_cd\n'

# Suggest commands as you type based on history and completions.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept # Use CTRL+SPACE for autocompletion.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Load aliases.
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# Rehash after package install/upgrade/remove.
catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  rehash
}
trap catch_signal_usr1 USR1

# Enable starship-prompt for terminal emulators.
if test "$TERM" != "linux"
then
  eval "$(starship init zsh)"
fi

# Configure pinentry to use the correct TTY.
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Fetch debug symbols without having to install the appropriate debug package. 
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"

# cht.sh tab completion
fpath=(~/.zsh/ $fpath)

# fzf key-bindings and completion.
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Fish-like syntax highlighting, must be at the end.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
