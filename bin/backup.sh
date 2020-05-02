#! /usr/bin/env bash
cryptsetup open /dev/disk/by-uuid/3fa1a48e-fcc6-4ead-bb73-0157f86223f4 backup01
mount /dev/mapper/backup01 /mnt/backup01
sudo nohup rsync -aAXv / --exclude={"/srv/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /mnt/backup01 </dev/null>
