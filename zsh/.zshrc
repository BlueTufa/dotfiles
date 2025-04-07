# Path to your oh-my-zsh installation.
export ZSH="$(dirname ${(%):-%x})/.oh-my-zsh"
export HISTFILE=~/.zsh_history

setopt append_history # this is default, but set for share_history
setopt share_history # import new commands from the history file also in other zsh-session
setopt extended_history # save each command's beginning timestamp and the duration to the history file
setopt histignorealldups # remove command lines from the history list when the first character on the line is a space

setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_verify # don't execute, just expand history
setopt hist_ignore_space # reduce whitespace in history
setopt inc_append_history # add comamnds as they are typed, don't wait until shell exit

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace 

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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

# helper function which automatically prompts awsume for sso-login if not authenticated
# Example: awsume dev
function awsume() {
  if aws sts get-caller-identity > /dev/null 2>&1; then
    source "$(pyenv which awsume)" "$@"
  else
    aws-sso-util login --profile "$@"
    source "$(pyenv which awsume)" "$@"
  fi
}

# helper function which logs into ecr using the specified profile
# Example: ecr-login dev
function ecr-login() {
  local environment="$1"
  awsume "$environment"

  local current_account
  current_account=$(aws sts get-caller-identity --query "Account" --output text)

  aws ecr get-login-password | docker login --username AWS --password-stdin "${current_account}.dkr.ecr.${AWS_REGION}.amazonaws.com"
}

# helper function to make it easier to start docker-compose without forgetting to build
# Example: env-up -d
function env-up() {
  # No args: start interactively, else use passed-in args
  docker-compose build
  docker-compose up --remove-orphans "$@"
}

# helper function to make it less typing to stop docker-compose
function env-down() {
  docker-compose down "$@"
}

autoload -Uz add-zsh-hook

# helper function which switches to a poetry shell upon change working directory
function _auto_poetry_shell() {
  # export VERBOSE=1 to debug / see details
  # deactivate any existing one first
  if [[ -n $VIRTUAL_ENV ]]; then
    [[ -n $VERBOSE ]] && echo "auto-deactivating $VIRTUAL_ENV"
    deactivate
  fi
  # only poetry is supported at this time
  if [[ -f "pyproject.toml" ]]; then
    [[ -n $VERBOSE ]] && echo "pyproject.toml detected at $(pwd)"

    if [[ ! -v POETRY_ACTIVE ]]; then
      [[ -n $VERBOSE ]] && echo "auto-activating poetry env @ $(poetry env info --path)"
      emulate bash -c ". $(poetry env info --path)/bin/activate" > /dev/null
    fi
  fi
}

add-zsh-hook chpwd _auto_poetry_shell

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# dotenv is built in to oh-my-zsh and will automatically source any .env files when you enter a directory
# ZSH_DOTENV_PROMPT=false  # Disable the confirmation prompt
# ZSH_DOTENV_FILE=".env.local"  # Change the default filename from .env, if preferred
# REMINDER: if you change the dotenv file name, you must include it in .gitignore
plugins=(
 dotenv
 fzf-tab
 git
 zsh-autosuggestions
)

# these will speed up docker-compose and docker build
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export COMPOSE_BAKE=True

# Preview file content when completing with CTRL-T
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Preview directory content when completing with ALT-C
export FZF_ALT_C_OPTS="--preview 'ls -la --color=always {}'"

# Enhanced history search with CTRL-R
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# helpful aliases
# NOTE: requires brew install watch gh
alias print-timestamp='watch --no-title date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias aws-ls='aws --endpoint=http://localhost:4566'
alias gh-pr='gh pr create --fill-first'
alias iso-date='date -u +"%Y-%m-%dT%H:%M:%SZ"'

# set up AWS CLI autocompletions
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit
which aws_completer > /dev/null && complete -C "$(which aws_completer)" aws

# uncomment this to configure the 1Password ssh agent
# export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
# uncomment this to set a common source code working directory
# export WORK_SRC=$HOME/src/rg/

source $ZSH/oh-my-zsh.sh

# are we on a macos system?
if [[ -n $(uname | grep "Darwin") ]]; then
  export MAC_APP_PATH='/System/Applications'
fi

bindkey -e

# You may also need to disable the bell and visual bell in iTerm2
bindkey '[C' forward-word
bindkey '[D' backward-word

for file in ~/.config/fish/.aliases*; do
  [[ -f $file ]] || [[ -L $file ]] && source $file
done

# NOTE: requires brew install starship
# see the sample starship.toml under the root of this repo.
# starship.toml should exist at ~/.config/starship.toml
eval "$(starship init zsh)"
