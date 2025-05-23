set -l is_darwin (test (uname) = "Darwin"; and echo true; or echo false)
set -l is_arm (test (uname -m) = "arm64"; and echo true; or echo false)

if $is_darwin; and $is_arm
  eval (/opt/homebrew/bin/brew shellenv)
end

set -l openssl_path (brew --prefix openssl)

set -gx GPG_TTY (tty)
set -gx EDITOR 'nvim'
set -gx AWS_PAGER 'bat --style=plain -l json'
set -gx NVM_DIR "$HOME/.nvm"

set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux fish_user_paths $fish_user_paths $PYENV_ROOT/bin "$HOME/src/bin" "$HOME/.cargo/bin" "$openssl_path/bin"

# these were needed by an old version of python,
# and possibly postgresql.  retire as soon as possible
set -gx LDFLAGS "-L$openssl_path/lib"
set -gx CPPFLAGS "-I$openssl_path/include"

set -gx AWS_COMPLETER (which aws_completer)
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

bind --user \cb backward-word
bind --user \cf forward-word
bind --user \cu upcase-word

fzf_configure_bindings --directory=\ct

function fzf_smart_preview
    if test -d "$argv"
      eza -l --color=always --no-permissions --no-filesize --no-user --git -m --time-style "+%Y-%m-%d %H:%M" "$argv"
    else if test -f "$argv"
        bat --color=always "$argv"
    end
end

set -gx FZF_CTRL_T_OPTS "--preview 'fzf_smart_preview {}'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --all --color=always'"

pyenv init - | source
starship init fish | source
zoxide init fish | source
docker completion fish | source
gh completion -s fish | source
poetry completions fish | source

# keeping these for the next time I need rust or K8s
# helm completion fish | source
# kubectl completion fish | source
# rustup completions fish | source

set -gx VSCODE_SETTINGS "$HOME/Library/Application Support/Code/User/settings.json"

# /usr/libexec/java_home -V to list versions
# set -gx JAVA_HOME (/usr/libexec/java_home -v11.0.9.1)
# set -g fish_user_paths "$JAVA_HOME/bin" "/usr/local/sbin" 
# set -gx LIQUIBASE_HOME /usr/local/opt/liquibase/libexec  

