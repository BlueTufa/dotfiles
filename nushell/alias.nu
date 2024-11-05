# alias ag = 'ag -i --color --hidden --ignore={node_modules,build,package-lock.json}'
alias clip = pbcopy

# alias ecr-login = 'aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com'
alias dk = docker
alias g = git
alias k = kubectl
alias h = history
alias gbr = git branch
alias gcl = git clone
alias gdd = cd ~/data
alias gps = git push
alias grep = ag
alias gst = git status
alias gd = git diff HEAD -- ':!package-lock.json' ':!Pipfile.lock'

alias gwdd = cd ~/src/dotfiles

# alias helm-ecr-login = 'aws ecr get-login-password | helm registry login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com'
# alias iso-date = date -u +"%Y-%m-%dT%H:%M:%SZ"

alias n = npm
# alias rg = 'rg -i --color=auto --colors=path:fg:yellow --colors=match:fg:green --hidden --no-ignore'

alias tf = terraform
alias vi = nvim
alias vim = nvim
alias gwd = cd ~/src/

def ll  [] { eza -aa -g --long --header --git }

def cat [...args: string] { bat --theme=ansi $args }

def pe [] { echo $env }

def rm [...args: string] { trash -v $args }
def sha256 [...args: string] { openssl sha256 $args }

def ga [] { git add . }

def gpl [] { git pull --all --prune --tags }

def ghb [] { 
    ^open (
        [
            (^git remote get-url --push origin | ^sed 's/\.git$//g'), 
            /tree/, 
            (^git rev-parse --abbrev-ref HEAD)
        ] | str join)

}
