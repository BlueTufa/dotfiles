#!/bin/bash
set -euxo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

# Config
IMG=arch-mini.qcow2
SIZE_MB=2048
DISK=arch-mini.raw
MNT=/mnt/arch

truncate -s ${SIZE_MB}M "$DISK"

# 1. Create new DOS partition table
# 2. Add primary partition (default values)
# 3. Make bootable
# 4. Write
parted -s "$DISK" mklabel msdos
parted -s "$DISK" mkpart primary ext4 2MiB 100%
parted -s "$DISK" set 1 boot on

# Setup loop device
LOOPDEV=$(losetup --show -fP "$DISK")  # Maps /dev/loopXp1
sleep 1  # Allow time for partition probing

# Format partition
mkfs.ext4 "${LOOPDEV}p1"

# Mount
mkdir -p "$MNT"
mount "${LOOPDEV}p1" "$MNT"

./pacstrap.sh -c "$MNT" base linux grub --disable-download-timeout

# Install GRUB to the MBR of the loop device
./arch-chroot.sh "$MNT" grub-install --target=i386-pc --recheck "$LOOPDEV"
./arch-chroot.sh "$MNT" grub-mkconfig -o /boot/grub/grub.cfg

# # Set hostname and root password
echo "archmini" | tee "$MNT/etc/hostname"
echo "root:root" | chroot "$MNT" chpasswd

# Unmount and detach loop
umount -R "$MNT"
losetup -d "$LOOPDEV"

# Convert to QCOW2
# qemu-img convert -f raw -O qcow2 "$DISK" "$IMG"
# rm -f "$DISK"
