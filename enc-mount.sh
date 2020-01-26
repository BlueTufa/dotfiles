#! /bin/bash

# PREREQUISITES
# fdisk n
# sudo apt install cryptsetup
# sudo cryptsetup luksFormat /dev/<device name>
# sudo cryptsetup open /dev/<device name> <mapper name>
# mkfs.ext4 /dev/mapper/<mapper name>

# /dev/disk/by-uuid/c62a39a0-08be-48d1-8875-43792abd24fd
cryptsetup open /dev/disk/by-uuid/fd702eda-bc50-48cb-b799-7d8cbefc31ad srv
mount -t ext4 /dev/mapper/srv /srv
