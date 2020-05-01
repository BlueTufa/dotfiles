#! /bin/bash

# trap "if [ -d $local_dir ]; then rm -rf $local_dir; fi" EXIT SIGINT 
trap "die" EXIT SIGINT

die() {
  if [ -d $local_dir ]; then
    echo "Removing $local_dir"
    rm -rf $local_dir
  fi
}

local_dir=$(mktemp -d -t sample.XXXX)
echo "Created $local_dir"
sleep 100
query="SELECT * FROM foo.bar;"
    
echo "$query" || exit 1
