#! /bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

if [[ -z "$1" ]]; then
  echo "Error: You must specify the destination path as an argument." >&2
  exit 1
fi

nohup rsync -aAXHv / --exclude={"/var/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/lost+found"} $1 2>&1 | tee -a full_backup.log > /dev/null &

