# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/jsanders/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
ZSH_DISABLE_COMPFIX=true
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias c="clear"

alias vim="nvim"
alias t="task list"
alias tc="task calendar"
alias td="task done"
alias tu="task add +URGENT"
alias ta="task add"

alias tl="tmux ls"
alias tma="tmux attach -t"
alias tmn="tmux new -t"
export EDITOR="nvim"

source ~/.nvm/nvm.sh

export CGB_USER="10"
export PATH="/usr/local/opt/yq@3/bin:$PATH"
export PATH="${HOME}/bin:${PATH}"

# JAVA
# export JAVA_HOME=/Library/Java/Home
# export JAVA_HOME=/user/local/Cellar/openjdk/java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home

# GOLANG
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# ZOXIDE
eval "$(zoxide init zsh)"

# KUBE_PS1 start
KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_NS_ENABLE=true

function get_cluster_short() {
  CLUSTER_NAME=$(echo $1 | awk -F / '{print $2}')
  SERVER=$(grep -A 1 -B 1 "${CLUSTER_NAME}" ~/.kube/config | grep server | sed -E "s/ *server: (.*)/\1/g")
  NEW_CLUSTER_NAMES=$(grep -A 1 -B 1 "${SERVER}" ~/.kube/config | grep name | grep -v ${CLUSTER_NAME} | sed -E "s/ *name: (.*)/\1/g")
  NEW_CLUSTER_NAME=${NEW_CLUSTER_NAMES%$'\n'*}
  if [[ -n "${NEW_CLUSTER_NAME}" ]]; then
    echo "${NEW_CLUSTER_NAME}"
  else
    echo ${CLUSTER_NAME}
  fi
}

KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

source "${HOME}/bin/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT
export PATH="${HOME}/.npm/bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.npm/bin:${PATH}"
export CGB_USER="XX"
export CGB_USER="XX"
export CGB_USER="10"
export PATH="/usr/local/opt/yq@3/bin:$PATH"
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.npm/bin:${PATH}"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source $HOME/.zsh_profile

# added by travis gem
[ ! -s /Users/jsanders/.travis/travis.sh ] || source /Users/jsanders/.travis/travis.sh
