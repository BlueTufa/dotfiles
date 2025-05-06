# Installing Arch Linux Without Installation Media

## Introduction

This guide explains how to install Arch Linux on a new drive using your existing Arch installation as the base environment, eliminating the need for bootable installation media. The process leverages three key concepts:

1. Using `pacman`'s `-r` flag to specify a target installation location
2. Mounting necessary system directories (`proc`, `sys`, etc.)
3. Using `chroot` to switch to the new environment

> **Note:** In the examples below, `_` is used as an alias for `sudo`.

## Prerequisites

- A running Arch Linux system
- A new, formatted drive mounted at `/mnt/newdrive`

## Step 1: Initialize the New Installation

First, create the necessary directory structure on your new drive:

```bash
cd /mnt/newdrive
_ mkdir -m 0555 -p {proc,dev}
_ mkdir -m 1777 -p tmp
_ mkdir -m 0755 -p var/log
_ mkdir -m 0755 -p var/{cache/pacman/pkg,lib/pacman} run
```

## Step 2: Install Basic Packages and Prepare for chroot

Install the package manager and a text editor on the new drive:

```bash
_ pacman -r /mnt/newdrive -Sy pacman
_ pacman -r /mnt/newdrive -Sy neovim
```

Mount the necessary system directories to prepare for chroot:

```bash
_ mount -o bind /dev /mnt/newdrive/dev/
_ mount -t proc /proc /mnt/newdrive/proc/
_ mount -t sysfs /sys /mnt/newdrive/sys/

# Important for EFI and GRUB
_ mount --make-rslave --rbind /sys /mnt/newdrive/sys
```

## Step 3: Enter the New Environment

Switch to the new installation:

```bash
_ chroot /mnt/newdrive
```

Verify system mounts are working by checking system information:

```bash
cat /proc/cpuinfo
```

## Step 4: Configure Networking and Package Management

Set up DNS configuration:

```bash
echo "nameserver 1.1.1.1" > /etc/resolv.conf
```

Initialize the pacman keyring:

```bash
pacman-key --init
pacman-key --populate archlinux
```

## Step 5: Install Essential Packages

Install the Linux kernel and EFI support:

```bash
pacman -Sy linux linux-firmware efibootmgr

# Set up symlinks for the editor
ln -s /usr/bin/nvim /usr/bin/vi
ln -s /usr/bin/nvim /usr/bin/vim
```

## Step 6: Configure Networking

Install and configure DHCP to ensure internet access on first boot:

```bash
pacman -S dhcpcd
```

Identify your network interface:

```bash
ip link show
```

Configure the network interface (replace `eno2` with your interface name):

```bash
# Create network configuration file
cat > /etc/systemd/network/eno2.network << EOF
[Match]
Name=eno2

[Network]
DHCP=true
EOF
```

## Step 7: Set Up Boot Manager (GRUB)

Install GRUB for an EFI system:

```bash
pacman -S grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch-kde
```

Don't forget to edit `/etc/fstab` to include your mount points, especially `/boot`!

Generate the GRUB configuration (critical before rebooting):

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

## Step 8: System Configuration

Set up localization:

```bash
# Edit /etc/locale.gen and uncomment your locale
# Then generate the locale
locale-gen

# Set time zone
ln -s /usr/share/zoneinfo/America/Denver /etc/localtime

# Configure console font
echo "FONT=/usr/share/kbd/consolefonts/ter-228b.psf.gz" > /etc/vconsole.conf
```

## Step 9: User Management

Create a user account:

```bash
pacman -S fish
useradd -G users -d /home/badger/ -s /usr/bin/fish badger
passwd badger
```

Set root password:

```bash
passwd
```

Configure sudo access:

```bash
pacman -S sudo
# Add your user to sudoers
echo "badger ALL=(ALL) ALL" > /etc/sudoers.d/badger
```

## Step 10: Final Package Installation

Install additional essential packages:

```bash
pacman -Sy base
pacman -S terminus-font which
```

## Summary of Installed Packages

```
base
linux
linux-firmware
efibootmgr
grub
terminus-font
sudo
fish
which
dhcpcd
neovim
```

## Important Reminders

- Run `grub-mkconfig -o /boot/grub/grub.cfg` before rebooting
- If you are using EFI, ensure `/boot` is properly mounted and in your `/etc/fstab`
- Properly configure DHCP to have network access on first boot
- If using a headless VM, make sure you have the following configured:
```GRUB
GRUB_CMDLINE_LINUX="console=ttyS0"
GRUB_TERMINAL_OUTPUT=console
```
