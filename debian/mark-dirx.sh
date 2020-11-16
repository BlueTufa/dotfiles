#! /bin/sh

tree -dfi | while read line
  do 
    if [ -d "$line" ]; then 
      echo "About to chmod directory: $line"
      chmod +x "$line"
    fi
  done
