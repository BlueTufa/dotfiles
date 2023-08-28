# alias .1 = 'cd ..'
# alias .2 = 'cd ../..'
# alias .3 = 'cd ../../..'
# alias .4 = 'cd ../../../..'
# alias .5 = 'cd ../../../../..'
# alias ag = 'ag -i --color --hidden --ignore={node_modules,build,package-lock.json}'
alias cat = bat --theme=ansi
alias clip = pbcopy
alias dk = docker
# alias ecr-login = 'aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com'
alias g = git

def ga [] { git add . }
# alias ga = git add .
alias gbr = git branch
alias gcl = git clone
# alias gd = git\\\ diff\\\ HEAD\\\ --\\\ \\\':!package-lock.json\\\'\\\ \\\':!Pipfile.lock\\\'
alias gdd = cd ~/data
alias gps = git push
alias grep = ag
alias gst = git status

# alias gwa = 'cd ~/src/$COMPANY/webapp'
alias gwdd = cd ~/src/dotfiles
# alias gwe 'cd ~/src/$COMPANY/web-internal'
# alias gwf 'cd ~/src/qmk_firmware'
# alias gwi 'cd ~/src/$COMPANY/api-internal'
# alias gwk 'cd ~/src/$COMPANY/kube'
# alias gwm 'cd ~/src/$COMPANY/api-manufacturing'
# alias gwp 'cd ~/src/$COMPANY/api-portal'
# alias gwr 'cd ~/src/$COMPANY/reads-processor'
# alias gws 'cd ~/src/$COMPANY/portal-data-simulator-v2'
# alias gwt 'cd ~/src/$COMPANY/terraform'
# alias gwt-dev 'cd ~/src/$COMPANY/terraform/aws/dev/'
# alias gwt-gh 'cd ~/src/$COMPANY/terraform/github/$COMPANY'
# alias gwt-ops 'cd ~/src/$COMPANY/terraform/aws/ops/'
alias h = history
# alias helm-ecr-login = 'aws ecr get-login-password | helm registry login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com'
# alias iso-date = date -u +"%Y-%m-%dT%H:%M:%SZ"
alias k = kubectl
alias lc = lolcat
def ll  [] { exa -aa -g --long --header --git }
alias n = npm
alias pe = printenv
# alias purge-remote-tags 'git tag -l | xargs git push --delete origin'
# alias rg = 'rg -i --color=auto --colors=path:fg:yellow --colors=match:fg:green --hidden --no-ignore'
def rm [...args: string] { trash -v $args }
def sha256 [...args: string] { openssl sha256 $args }
alias tf = terraform
alias vi = nvim
alias vim = nvim
alias gwd = cd ~/src/


