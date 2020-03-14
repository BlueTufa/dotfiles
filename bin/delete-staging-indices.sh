#! /bin/bash

for line in $(curl 'https://search-stagingme-76yrkk27nacwtjeq6d7vf7by5y.us-west-2.es.amazonaws.com/_cat/indices?v' | awk '{print $3 }' | grep '^activity.');do
  curl -XDELETE "https://search-stagingme-76yrkk27nacwtjeq6d7vf7by5y.us-west-2.es..amazonaws.com/${line}"
  echo $line
done

