#!/bin/bash
set -euo pipefail

IMG="arch-efi-luks.img"
SIZE=3G
MNT=/mnt/arch
LOOP=

echo "==> Creating raw image"
truncate -s $SIZE $IMG

echo "==> Partitioning (GPT + EFI + LUKS)"
parted $IMG --script mklabel gpt
parted $IMG --script mkpart ESP fat32 1MiB 513MiB
parted $IMG --script set 1 boot on
parted $IMG --script mkpart primary ext4 513MiB 100%

LOOP=$(losetup --find --show --partscan "$IMG")
mkfs.vfat -F32 "${LOOP}p1"

echo "==> Encrypting root partition"
echo -n "testpass" | cryptsetup luksFormat "${LOOP}p2" -
echo -n "testpass" | cryptsetup open "${LOOP}p2" cryptroot -

mkfs.ext4 /dev/mapper/cryptroot

echo "==> Mounting filesystems"
mount /dev/mapper/cryptroot $MNT
mkdir -p $MNT/boot
mount "${LOOP}p1" $MNT/boot

echo "==> Installing Arch base system"
pacstrap -K $MNT base linux linux-firmware systemd-boot vim mkinitcpio

echo "==> Generating fstab"
genfstab -U $MNT >> $MNT/etc/fstab

echo "==> Configuring system"
arch-chroot $MNT bash -c "
  ln -sf /usr/share/zoneinfo/UTC /etc/localtime
  hwclock --systohc
  echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
  locale-gen
  echo 'LANG=en_US.UTF-8' > /etc/locale.conf
  echo 'archluks' > /etc/hostname
  echo 'root:testpass' | chpasswd
"

echo "==> Setting up crypttab"
UUID=$(blkid -s UUID -o value "${LOOP}p2")
echo "cryptroot UUID=$UUID none luks" > $MNT/etc/crypttab

echo "==> Configuring mkinitcpio for LUKS"
sed -i 's/^HOOKS=.*/HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)/' $MNT/etc/mkinitcpio.conf
arch-chroot $MNT mkinitcpio -P

echo "==> Installing systemd-boot"
arch-chroot $MNT bootctl install

echo "==> Creating boot entry"
cat > $MNT/boot/loader/loader.conf <<EOF
default arch
timeout 3
editor no
EOF

cat > $MNT/boot/loader/entries/arch.conf <<EOF
title   Arch Linux (LUKS)
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options cryptdevice=UUID=$UUID:cryptroot root=/dev/mapper/cryptroot rw
EOF

echo "==> Cleanup"
umount -R $MNT
cryptsetup close cryptroot
losetup -d $LOOP

echo "✅ Done! Image ready: $IMG"

echo "==> Test with:"
echo "qemu-system-x86_64 -drive file=$IMG,format=raw -enable-kvm -m 2048 -cpu host -bios /usr/share/ovmf/x64/OVMF_CODE.fd"
