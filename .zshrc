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
bindkey -v '^?' backward-delete-char

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

# Enable spaceship-prompt for terminal emulators.
if test "$TERM" != "linux"
then
  autoload -U promptinit; promptinit
  prompt spaceship
  SPACESHIP_PROMPT_ORDER=(
    #time          # Time stamps section
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    #hg            # Mercurial section (hg_branch  + hg_status)
    #package       # Package version
    #gradle        # Gradle section
    #maven         # Maven section
    #node          # Node.js section
    #ruby          # Ruby section
    #elixir        # Elixir section
    #xcode         # Xcode section
    #swift         # Swift section
    #golang        # Go section
    #php           # PHP section
    #rust          # Rust section
    #haskell       # Haskell Stack section
    #julia         # Julia section
    #docker        # Docker section
    #aws           # Amazon Web Services section
    #gcloud        # Google Cloud Platform section
    #venv          # virtualenv section
    #conda         # conda virtualenv section
    #pyenv         # Pyenv section
    #dotnet        # .NET section
    #ember         # Ember.js section
    #kubectl       # Kubectl context section
    #terraform     # Terraform workspace section
    #ibmcloud      # IBM Cloud section
    #exec_time     # Execution time
    #line_sep      # Line break
    #battery       # Battery level and status
    #vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
  )
  SPACESHIP_USER_SHOW=needed
  SPACESHIP_DIR_TRUNC=4
  SPACESHIP_EXIT_CODE_SHOW=true
  SPACESHIP_EXIT_CODE_SYMBOL=""
  SPACESHIP_CHAR_SYMBOL="❯ "
  SPACESHIP_CHAR_SYMBOL_ROOT=$SPACESHIP_CHAR_SYMBOL
fi

# Configure pinentry to use the correct TTY.
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Fetch debug symbols without having to install the appropriate debug package. 
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"

# cht.sh tab completion
fpath=(~/.zsh/ $fpath)

# If tmux is executable, X is running, and not inside a tmux session, then try to attach.
# If attachment fails, start a new session
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmuxp load amalliar; } >/dev/null 2>&1
fi

eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"

# Fish-like syntax highlighting, must be at the end.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
