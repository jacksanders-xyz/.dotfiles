# At the very top of ~/.zshrc
zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/jsanders/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"


# Plugins
plugins=(
  git
  vi-mode
)

# you can manualy update with $ omz update
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
source "$ZSH/oh-my-zsh.sh"

# Aliases
alias c="clear"
alias vim="nvim"
alias ocd="opencode"
alias ocdp="opencode --port"
alias t="task list"
alias twt="taskwarrior-tui"
alias tc="$HOME/.local/bin/gen_task_project_colors.py"
alias tC="task calendar"
alias td="task done"
alias tu="task add +URGENT"
alias ta="task add"
alias tl="tmux ls"
alias tma="tmux attach -t"
alias tmn="tmux new -t"

export EDITOR="nvim"

# Load NVM
# source ~/.nvm/nvm.sh

# Set user variable
export CGB_USER="10"

# Path Configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Custom paths, avoiding duplicates
export PATH="/usr/local/opt/yq@3/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home

# Golang
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# Zoxide
eval "$(zoxide init zsh)"

# IBM cluster script

# # Kube PS1 prompt settings
# KUBE_PS1_SYMBOL_ENABLE=false
# KUBE_PS1_NS_ENABLE=true
#
# # Cluster name function for kube_ps1
# function get_cluster_short() {
#   CLUSTER_NAME=$(echo $1 | awk -F / '{print $2}')
#   SERVER=$(grep -A 1 -B 1 "${CLUSTER_NAME}" ~/.kube/config | grep server | sed -E "s/ *server: (.*)/\1/g")
#   NEW_CLUSTER_NAMES=$(grep -A 1 -B 1 "${SERVER}" ~/.kube/config | grep name | grep -v ${CLUSTER_NAME} | sed -E "s/ *name: (.*)/\1/g")
#   NEW_CLUSTER_NAME=${NEW_CLUSTER_NAMES%$'\n'*}
#   if [[ -n "${NEW_CLUSTER_NAME}" ]]; then
#     echo "${NEW_CLUSTER_NAME}"
#   else
#     echo ${CLUSTER_NAME}
#   fi
# }
#
# KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
# source "${HOME}/bin/kube-ps1.sh"
# PROMPT='$(kube_ps1)'$PROMPT

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source $HOME/.zsh_profile

# Travis gem
# [ ! -s /Users/jsanders/.travis/travis.sh ] || source /Users/jsanders/.travis/travis.sh

# IBM db2profile
export PATH="/Applications/dsdriver/bin:/Applications/dsdriver/adm:$PATH"
export DYLD_LIBRARY_PATH="/Applications/dsdriver/lib:$DYLD_LIBRARY_PATH"
export CLASSPATH="/Applications/dsdriver/java/db2jcc4.jar:/Applications/dsdriver/java/sqlj4.zip:$CLASSPATH"
export CLASSPATH="/Applications/dsdriver/tools/clpplus.jar:/Applications/dsdriver/tools/jline-0.9.93.jar:/Applications/dsdriver/tools/antlr-3.3-java.jar:$CLASSPATH"

# Powerlevel9k Configuration
# POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Pipx path
export PATH="$PATH:/Users/jsanders/.local/bin"

# lazy rocks
export PATH="$HOME/.local/share/nvim/lazy-rocks/bin:$PATH"

# Daypart env variable for your colors
[ -f ~/.config/env/daypart.zsh ] && source ~/.config/env/daypart.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# At the very bottom of ~/.zshrc
zprof

