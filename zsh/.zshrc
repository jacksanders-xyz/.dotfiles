# Enable Powerlevel10k instant prompt. Keep this near the top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Homebrew setup: must come before brew/zoxide usage.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Plugins
plugins=(
  git
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
  fzf-tab
)

# Optional completion cache
autoload -Uz compinit
if [[ -r ~/.zcompdump ]]; then
  compinit -C -d ~/.zcompdump
else
  compinit -d ~/.zcompdump
fi

# you can manually update with: omz update
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
source "$ZSH/oh-my-zsh.sh"

# Aliases
alias c="clear"
alias vim="nvim"
alias t="task list"
alias ocd="opencode"
alias ocdp="opencode --port"
alias tc="$HOME/.local/bin/gen_task_project_colors.py"
alias tC="task calendar"
alias td="task done"
alias tu="task add +URGENT"
alias ta="task add"
alias tl="tmux ls"
alias tma="tmux attach -t"
alias tmn="tmux new -t"

export EDITOR="nvim"
export CGB_USER="10"

# Base/custom paths
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/lazy-rocks/bin:$PATH"
export PATH="/usr/local/opt/yq@3/bin:$PATH"
export PATH="/Applications/dsdriver/bin:/Applications/dsdriver/adm:$PATH"

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"

# Golang
export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang 2>/dev/null)/libexec"
export PATH="$PATH:$GOPATH/bin"
[[ -n "$GOROOT" ]] && export PATH="$PATH:$GOROOT/bin"

# Zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Your custom profile file
[[ -f "$HOME/.zsh_profile" ]] && source "$HOME/.zsh_profile"

# IBM db2profile
export DYLD_LIBRARY_PATH="/Applications/dsdriver/lib:$DYLD_LIBRARY_PATH"
export CLASSPATH="/Applications/dsdriver/java/db2jcc4.jar:/Applications/dsdriver/java/sqlj4.zip:$CLASSPATH"
export CLASSPATH="/Applications/dsdriver/tools/clpplus.jar:/Applications/dsdriver/tools/jline-0.9.93.jar:/Applications/dsdriver/tools/antlr-3.3-java.jar:$CLASSPATH"

# Daypart env if present
[ -f ~/.config/env/daypart.zsh ] && source ~/.config/env/daypart.zsh

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
