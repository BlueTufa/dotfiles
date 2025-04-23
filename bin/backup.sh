#! /usr/bin/env bash

DISK_UUID=3fa1a48e-fcc6-4ead-bb73-0157f86223f4
MOUNT_PATH=/mnt/backup01

if [[ $(uname) != "Linux" ]]; then
  echo "This script is only supported on Linux."
  exit 1
fi

# command must be run as sudo, the whole thing
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root. Try using sudo." >&2
    exit 1
fi

cryptsetup status backup01
[[ $? -eq 0 ]] || cryptsetup open /dev/disk/by-uuid/${DISK_UUID} backup01
grep -qs '/dev/mapper/backup01' /proc/mounts
[[ $? -eq 0 ]] || mount /dev/mapper/backup01 ${MOUNT_PATH}
nohup rsync -aAXHv / --exclude={"/var/*","/srv/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} ${MOUNT_PATH} </dev/null
