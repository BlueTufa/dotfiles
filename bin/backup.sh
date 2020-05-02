#! /usr/bin/env bash

DISK_UUID=3fa1a48e-fcc6-4ead-bb73-0157f86223f4
MOUNT_PATH=/mnt/backup01

# command must be run as sudo, the whole thing
if [[ $(whoami) != "root" ]]; then
  echo "You must run this backup script as root for hardware access."
  exit 1
fi

cryptsetup status backup01
[[ $? -eq 0 ]] || cryptsetup open /dev/disk/by-uuid/${DISK_UUID} backup01
grep -qs '/dev/mapper/backup01' /proc/mounts
[[ $? -eq 0 ]] || mount /dev/mapper/backup01 ${MOUNT_PATH}
nohup rsync -aAXv / --exclude={"/var/*","/srv/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} ${MOUNT_PATH} </dev/null
