abbr --add print-timestamp watch --no-title date -u +"%Y-%m-%dT%H:%M:%SZ"

abbr --add iso-date 'date -u +"%Y-%m-%dT%H:%M:%SZ"'

# dangerous, but helpful
abbr --add purge-remote-tags 'git tag -l | xargs git push --delete origin'

abbr --add gen-cert 'openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -sha256 -days 3650 -nodes -subj "/C=US/ST=California/L=SanFrancisco/O=RadiantGraph/CN=radiantgraph.com"'
abbr --add gen-keypair 'openssl genrsa -out private_key.pem 2048; and openssl rsa -in private_key.pem -pubout -out public_key.pem'

abbr --add gh-pr 'gh pr create --fill-first'
abbr --add gh-make-draft 'gh pr ready --undo'

abbr --add cmp-gen 'functions -n; builtin -n; alias -n; for dir in $PATH; ls $dir; end'

abbr --add pop 'cd (pwd)'
abbr --add find-empty-folders 'find . -type d -empty'
abbr --add lab-wol 'wakeonlan -i 192.168.160.255 b0:82:e2:3c:6f:61'
abbr --add lab2-wol 'wakeonlan -i 192.168.160.255 04:d4:c4:4a:9f:2b'

# Kubernetes aliases, not in use right now
# abbr --add kp 'kubectl -n prod'
# abbr --add kc 'kubectl -n dev'
# abbr --add helm-ecr-login='aws ecr get-login-password | helm registry login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com'
