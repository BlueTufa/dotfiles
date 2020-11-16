#! /bin/sh

cryptsetup open UUID="6da19ca9-aced-410e-b5ef-e71f9456a9e2" encrypted
mount -t ext4 /dev/mapper/encrypted /boneyard

# cryptsetup open UUID="c1e99df3-3a5d-49ea-99dd-5c33defcd42e" backup01
# mount -t ext4 /dev/mapper/backup01 /boneyard/backup01

# cryptsetup open UUID="970d2584-6d02-4d13-9d58-95bef371cee7" backup02
# mount -t ext4 /dev/mapper/backup02 /boneyard/backup02

