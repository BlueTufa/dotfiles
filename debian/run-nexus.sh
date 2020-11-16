#! /bin/bash
docker run --name nexus-oss -d -p8081:8081 -v /data/docker/nexus:/nexus-data sonatype/nexus3:3.27.0
