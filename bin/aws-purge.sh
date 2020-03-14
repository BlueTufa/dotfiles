#! /bin/bash

aws ecs list-task-definitions | grep 'arn:' | sed 's/"//g' | sed 's/,//' | while read l 
do
  echo "De-registering task definition: $l"
  aws ecs deregister-task-definition --task-definition=$l
done

# rm tmp.in
