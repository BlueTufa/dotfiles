#! /bin/bash

while IFS= read -r line; do echo ${line:9}; done < awsconfig
