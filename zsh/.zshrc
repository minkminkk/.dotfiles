# Tmux auto-attach to a main session - except for vscode & iterm2 shell
if [[ "$TERM_PROGRAM" != "vscode" && "$LC_TERMINAL" != "iTerm2" ]] && command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t main &> /dev/null || tmux new-session -s main
fi


# Autosuggestion load
autoload -Uz compinit
compinit


# History config
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000


# Custom history per tmux session
if [[ -n "$TMUX" ]]; then
    TMUX_HIST_DIR="$HOME/.zsh_history_tmux"
    mkdir -p $TMUX_HIST_DIR

    TMUX_SESSION_NAME=$(tmux display-message -p "#S")
    export HISTFILE="$TMUX_HIST_DIR/$TMUX_SESSION_NAME"
fi


# Environment variables
export TERM=xterm-256color
export PATH="/snap/bin:/usr/local/go/bin:$HOME/.local/bin:$PATH"	# add installed snap binaries into PATH
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PYTHONDONTWRITEBYTECODE=1
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1  # Optional: No telemetry
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1 # Disable a Haiku call just to set Terminal titleexport CLAUDE_CODE_REMOTE=true # Disable warm up calls to Haiku and opus model
export CLAUDE_CODE_ENABLE_TELEMETRY=0
export K9S_CONFIG_DIR="$HOME/.config/k9s"


# Aliases
alias ll="ls -al"

alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias gp="git push"
alias gst="git status"

alias k="kubectl"
alias kx="kubectx"
alias g="gcloud"
alias tf="terraform"
alias v="nvim"


# Zsh plugins & external scripts
eval "$(starship init zsh)"
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/gcp-https-tunnel


# Node version manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # --no-use have to loads nvm manually by `nvm use` due to slow startup time
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

