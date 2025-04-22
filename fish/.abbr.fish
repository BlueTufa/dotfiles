abbr --add db-migrate-prod "run-ecs-task prod task-definition/database-migrations-task --cluster rg-us-e1-prod-web-cluster --network-configuration=\''awsvpcConfiguration={subnets=[subnet-0189c234c09672b16],securityGroups=[sg-0c925e447aa200420]}\''"
abbr --add db-migrate-dev "run-ecs-task dev task-definition/database-migrations-task --cluster rg-us-e1-dev-cluster --network-configuration=\''awsvpcConfiguration={subnets=[subnet-0f91b65d392895393],securityGroups=[sg-018d21aeabb7852de]}\''"
abbr --add update-service-dev "aws ecs update-service --force-new-deployment --cluster rg-us-e1-dev-cluster --service"
abbr --add update-service-prod "aws ecs update-service --force-new-deployment --cluster rg-us-e1-prod-cluster --service"

abbr --add print-timestamp watch --no-title date -u +"%Y-%m-%dT%H:%M:%SZ"

abbr --add tf-github "awsume mgmt; and cd $WORK_SRC/terraform/github/"
abbr --add tf-data "awsume data; and cd $WORK_SRC/terraform/aws/data"
abbr --add tf-dev "awsume dev; and z $WORK_SRC/terraform/aws/dev"
abbr --add tf-prod "awsume prod; and z $WORK_SRC/terraform/aws/prod"
abbr --add tf-ops1 "awsume mgmt; and z $WORK_SRC/terraform/aws/ops/us-east-1"
abbr --add tf-ops2 "awsume mgmt; and z $WORK_SRC/terraform/aws/ops/us-east-2/sftp"

abbr --add aws-ls 'aws --endpoint=http://localhost:4566'
abbr --add iso-date 'date -u +"%Y-%m-%dT%H:%M:%SZ"'

# dangerous, but helpful
abbr --add purge-remote-tags 'git tag -l | xargs git push --delete origin'

abbr --add gen-cert 'openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -sha256 -days 3650 -nodes -subj "/C=US/ST=California/L=SanFrancisco/O=RadiantGraph/CN=radiantgraph.com"'
abbr --add gen-keypair 'openssl genrsa -out private_key.pem 2048; and openssl rsa -in private_key.pem -pubout -out public_key.pem'

abbr --add gh-pr 'gh pr create --fill-first'

abbr --add cmp-gen 'functions -n; builtin -n; alias -n; for dir in $PATH; ls $dir; end'

abbr --add pop 'cd (pwd)'
abbr --add be 'cd $WORK_SRC/backend-api'
abbr --add new-api 'cd $WORK_SRC/cohorts-api'

# Kubernetes aliases, not in use right now
# abbr --add kp 'kubectl -n prod'
# abbr --add kc 'kubectl -n dev'
# abbr --add helm-ecr-login='aws ecr get-login-password | helm registry login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com'
