#! /bin/bash
docker run --name artifactory-oss -d -p8081:8081 -p8082:8082 -v /data/docker/artifactory:/var/opt/jfrog/artifactory docker.bintray.io/jfrog/artifactory-oss:7.7.8
