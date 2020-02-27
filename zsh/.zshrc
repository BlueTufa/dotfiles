# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# are we on a macos system?
if [[ -n $(uname | grep "Darwin") ]]; then
  # are we on catalina?
  if [[ -n $(sw_vers -productVersion | grep '^10.15' 2> /dev/null) ]]; then
    export MAC_APP_PATH='/System/Applications'
  else
    export MAC_APP_PATH='/Applications'
  fi
fi

# ZSH_THEME="~/.powerlevel10k/powerlevel10k"
# POWERLEVEL9K_STATUS_OK_BACKGROUND='000' #alpha
# POWERLEVEL9K_STATUS_OK_FOREGROUND='040' #green
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND='196' #red
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND='226' #yellow
# POWERLEVEL9K_MODE='nerdfont-complete'



# . '~/Library/Fonts/10-powerline-symbols.conf'
# '/usr/local/lib/python2.7/site-packages/powerline/bindings/tmux/powerline.conf'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
 git
 dotenv
 osx
)

source $ZSH/oh-my-zsh.sh

# POWERLINE stuff
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator command_execution_time background_jobs time)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# shared aliases
source ~/.config/fish/.aliases
source ~/.config/fish/.aliasesDarwin


# bindkey '^[[1;1C' emacs-forward-word
# bindkey '^[[1;1D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
