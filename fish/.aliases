set -l is_darwin (test (uname) = "Darwin"; and echo true; or echo false)

alias h='history'
alias vi='nvim'
alias vim='nvim'
alias wtr='curl http://wttr.in/Grand_Junction'

alias rg='rg -i --color=auto --colors=path:fg:yellow --colors=match:fg:green --hidden -g "!Library/Caches/Homebrew/api/formula.jws.json"'
alias rgi='rg -g !package-lock.json -g !poetry.lock -g !Cargo.lock'

alias pe='printenv'
alias cat='bat --theme=ansi'
alias less='bat --theme=ansi'
alias rm='trash -v'

alias l='eza -aa -g --long --header --git'
alias ll='eza -aa -g --long --header --git'
alias lr='fd -aH -t f'

alias md5='openssl md5'
alias sha1='openssl sha1'
alias sha256='openssl sha256'

alias gwdd='cd ~/src/dotfiles'
alias gwf='cd ~/src/qmk/qmk_firmware'

alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias dk='docker'
alias k='kubectl'
alias tf='terraform'

alias gwd='cd $WORK_SRC'
alias gwt='cd $WORK_SRC/terraform'

# git aliases
alias g='git'
alias ga='git add .'
alias gpl="git pull --all --prune --tags --rebase --autostash -v"

alias gd="git diff HEAD -- ':!package-lock.json' ':!Cargo.lock' ':!poetry.lock'"
alias gst='git status'
alias gbr='git branch'
alias gps='git push'
alias diff='git diff --no-index'

if $is_darwin
  # Darwin version of clipboard from command line
  alias clip='pbcopy'
  
  set -gx MAC_APP_PATH '/System/Applications'

  # aliases for gui mode apps
  # NOTE: may need to add -f after -g any time you want to block from the CLI
  alias actmon="open $MAC_APP_PATH/Utilities/Activity\ Monitor.app"
  alias calc="open $MAC_APP_PATH/Calculator.app"
  alias console="open $MAC_APP_PATH/Utilities/Console.app"
  alias gdu="open $MAC_APP_PATH/Utilities/Disk\ Utility.app"
  alias prefs="open $MAC_APP_PATH/System\ Preferences.app"
  
  alias slack="open /Applications/Slack.app"
  alias sqlwb="open /Applications/DataGrip.app"
  alias xbrew='arch -x86_64 /usr/local/bin/brew'
end

if test -f /etc/os-release
  alias cat='batcat --theme=ansi'
end

