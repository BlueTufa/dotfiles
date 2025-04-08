# Path to your oh-my-zsh installation.
export ZSH="$(dirname ${(%):-%x})/.oh-my-zsh"
export HISTFILE=~/.zsh_history

setopt append_history         # this is default, but set for share_history
setopt share_history          # import new commands from the history file also in other zsh-session
setopt extended_history       # save each command's beginning timestamp and the duration to the history file
setopt histignorealldups      # remove command lines from the history list when there are duplicates
setopt histignorespace        # remove command lines from the history list when the first character on the line is a space

setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # ignore duplication command history list
setopt hist_verify            # don't execute, just expand history
setopt hist_ignore_space      # reduce whitespace in history
setopt inc_append_history     # add commands as they are typed, don't wait until shell exit

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

# dotenv is built in to oh-my-zsh and will automatically source any .env files when you enter a directory
# ZSH_DOTENV_PROMPT=false  # Disable the confirmation prompt
# ZSH_DOTENV_FILE=".env.local"  # Change the default filename from .env, if preferred
# REMINDER: if you change the dotenv file name, you must include it in .gitignore
plugins=(
 aws
 dotenv
 fzf
 gh
 pyenv
 starship
 zsh-autosuggestions
)

# # set up AWS CLI autocompletions
# autoload -Uz bashcompinit && bashcompinit
# autoload -Uz compinit && compinit
# which aws_completer > /dev/null && complete -C "$(which aws_completer)" aws

# uncomment this to configure the 1Password ssh agent
# export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
# uncomment this to set a common source code working directory
# export WORK_SRC=$HOME/src/rg/

source $ZSH/oh-my-zsh.sh

bindkey -e

# You may also need to disable the bell in iTerm2
bindkey '[C' forward-word
bindkey '[D' backward-word

for file in ~/.zsh/.{exports*,aliases,functions}
do
  [[ -f $file ]] && source $file
done
