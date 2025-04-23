function ghb --description="Calculate and attempt to open a GitHub URL for the current branch"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set --local remote_url (git remote get-url --push origin 2>/dev/null | sed 's/\.git$//g')/tree/(git rev-parse --abbrev-ref HEAD)
    open $remote_url
  else
    echo "Not a git repo"
  end
end

function glc --description="Print the most recent commit as a hyperlink with optional prefix text"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set --local remote_url (git remote get-url --push origin 2>/dev/null | sed 's/\.git$//g')
    set --local commit_hash (git rev-parse HEAD)
    echo "$remote_url/commit/$commit_hash"
  else
    echo "Not a git repo"
  end
end

function fish_greeting --description="Override default behavior with a custom fish_greeting function"
  set -l is_darwin (test (uname) = "Darwin"; and echo true; or echo false)
  # set -l is_local (test "$SSH_TTY" = ""; and echo true; or echo false)
  set -l is_vscode (test "$TERM_PROGRAM" = "vscode"; and echo true; or echo false)
  set -l is_jetbrains (test "$TERMINAL_EMULATOR" = "JetBrains-JediTerm"; and echo true; or echo false)
  set -l has_macchina (command -v macchina >/dev/null 2>&1; and echo true; or echo false)
  set -l has_fastfetch (command -v fastfetch >/dev/null 2>&1; and echo true; or echo false) 

  if $is_vscode; or $is_jetbrains
    return
  end
  
  if $is_darwin; and $has_macchina
      macchina
  else if $has_fastfetch
    fastfetch 
  end
end

function cal --description "Enhanced calendar with qtr, cy, eoy support + lolcat"
  set arg $argv[1]

  switch $arg
    case ''
      /usr/bin/cal | lolcat 2>/dev/null

    case qtr
      set m (date -u +%m)
      set mb (math "($m - 1) % 3")
      set mf (math "2 - $mb")
      set opts
      test $mb -gt 0; and set opts $opts -B$mb
      test $mf -gt 0; and set opts $opts -A$mf
      /usr/bin/cal $opts | lolcat 2>/dev/null

    case eoy
      set m (date -u +%m)
      set rem (math "12 - $m")
      /usr/bin/cal -A$rem | lolcat 2>/dev/null

    case cy
      /usr/bin/cal (date -u +%Y) | lolcat 2>/dev/null

    case '*'
      /usr/bin/cal $argv | lolcat 2>/dev/null
  end
end

# Opens in an OS window, either the current working directory, or the object(s) passed as arguments
function o --description="Open a given command as OS-native, or open the current working directory in an os-native browser"
  set -l is_darwin (test (uname) = "Darwin"; and echo true; or echo false)
  if $is_darwin
    open $argv
  else
    echo "Not implemented"
  end
end

function gen-machine-name --description="Generate a semi-ramdon machine name that meets a specific naming pattern"
  pwgen -s1 11 100000 | tr [a-z] [A-Z] | grep '^[^aeiou0-9]{1,1}[aeiou]{1,1}[^aeiou0-9]{1,2}[aeiou]{1}[^aeiou0-9]{1,1}[aeiou]{1,1}[^aeiou0-9]{1,2}[aeiou]{1}' | tail -n 1
end

function cd --description="Change current working directory"
  # requires zoxide, installed via Homebrew
  z $argv
  emit cwd
end

function __check_cwd --on-event cwd --description="Inject directory specific behaviors on change working directory"
  go-nvm
  go-py
  go-env
  go-codeartifact
end

function env-source --description="Injects environment variables into the current session"
  if test (count $argv) -eq 0
    echo "Usage: env-source <file>"
    return 1
  end

  for line in (cat $argv | string trim)
    # Skip and show comments
    if string match -rq '^\s*#' $line
      echo $line
      continue
    end

    # Skip empty lines
    if test -z "$line"
      continue
    end

    # Split key=value
    set item (string split -m 1 '=' $line)
    set key $item[1]
    set val $item[2]

    # Check if value is a command like $(...)
    # This supports the arbitrary execution of commands into an env var
    # A common use case for this is password retrieval from a password manager
    set matches (string match -r '^\$\((.+)\)$' $val)
    if test -n "$matches"
      # echo "env $matches[2] needs execution"
      set -gx $key (eval $matches[2] | string trim)
    else
      set -gx $key $val
    end

    echo "Exported key $key" # don't print the value for security reasons
  end
end

function env-up --description="Docker compose helper"
  # no args, then start as interactive
  # else, use whatever args are passed in
  docker-compose build
  docker-compose up --remove-orphans $argv
end

function env-down
  docker-compose down $argv
end

function go-py --description="Deactivate/activate virtual environment on change working directory" 
  if test "$VIRTUAL_ENV" != ""
    deactivate
  end

  if test -d "venv" && test -f "venv/bin/activate.fish"
    source venv/bin/activate.fish
  end

  if test -d ".venv" && test -f ".venv/bin/activate.fish"
    source .venv/bin/activate.fish
  end

  if test -f pyproject.toml
    source (poetry env info --path)/bin/activate.fish
  end
end

function go-codeartifact --description="Auto-load code artifact environment variables"
  if test -f codeartifact-login.sh; and test "$AWS_SESSION_TOKEN" != ""
    source ./codeartifact-login.sh
    echo "AWS CODE_ARTIFACT_AUTH_TOKEN was set."
  end
end

function go-env --description="Auto-load .env file contents on enter"
  if test -f .env
    env-source .env
  end
end

function go-nvm --description="Run Node version manager use on enter / exit"
  if test -e "$PWD/.nvmrc" && test -f (which nvm)
    nvm use
  end
end

function sonar-scan --description="Run a Sonar scan from the root of a GitHub repository"
  rm -rf .scannerwork/
  docker run \
          --rm \
          -e SONAR_HOST_URL="$SONAR_HOST" \
          -e SONAR_LOGIN="$SONAR_TOKEN" \
          -e SONAR_SCANNER_OPTS="-Xms1024m -Xmx4096m -Dsonar.verbose=true" \
          -v "$PWD:/usr/src" \
          sonarsource/sonar-scanner-cli
end

function reformat-json --description="Reformats your jason"
  for file in (fd '\.json$')
    echo "About to reformat json: $file"
    jq . $file
    if test "$status" -eq 0
      jq . $file | tee $file
    end
  end
end

function gen-key --description="Generates a random 256-bit seed value and prints it as hex"
  if test "$argv" = ""
    set numbytes 32
  else 
    set numbytes "$argv"
  end
  node -e "console.log(Buffer.from(crypto.randomBytes($numbytes)).toString('hex'))"
end

function invoke-lambda --description="Invokes a lambda in a specific AWS environment"
  set environ "$argv[1]"
  set arn "$argv[2]"
  set payload (echo "$argv[3]" | base64)
  aws lambda invoke --function=$arn --payload=$payload --profile=$environ lambda-invoke-(iso-date | sed 's/:/-/g').out
end

function cw-logs --description="tails AWS logs in a specific environment"
  set proj "$argv[1]"
  if test "$proj" = ""
    echo (set_color red)"ERROR: you must specify a project"(set_color normal)
  end

  aws logs tail $proj $argv[2..-1]
end

function ecr-login --description="Logs in to the specified environment"
  set environment "$argv[1]"
  awsume $environment
  set current_account (aws sts get-caller-identity --query "Account" --output text)
  eval "aws ecr get-login-password | docker login --username AWS --password-stdin $current_account.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
end

function run-ecs-task --description="Runs an ECS task"
  set environment "$argv[1]"
  set task_definition "$argv[2..-1]"
  awsume $environment
  set current_account (aws sts get-caller-identity --query "Account" --output text)
  eval "aws ecs run-task --task-definition arn:aws:ecs:$AWS_REGION:$current_account:$task_definition"
end

function awsume
  if test (count $argv) -eq 0
    set argv "default"
  end
  if aws sts get-caller-identity > /dev/null 2>&1
    source (pyenv which awsume.fish) $argv
  else
    aws-sso-util login --profile $argv
    source (pyenv which awsume.fish) $argv
  end
end

