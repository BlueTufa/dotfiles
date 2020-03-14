#! /bin/bash

# finds log groups for old environments and purges them
# BOTO3 might be a little safer for this in the future
aws logs describe-log-groups | \
  grep logGroupName | \
  sed 's/"logGroupName": //' \
  | sed 's/[,"]//g' | \
  awk '{$1=$1};1' | grep "^\/${ENVIRONMENT_NAME}\/" | while read l
do
  echo "Purging log group: $l"
  aws logs delete-log-group --log-group-name=$l
done

