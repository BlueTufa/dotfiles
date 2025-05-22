#! /bin/bash

INSTANCE_ID=${1:-"arch-recovery"}
SSH_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwt/pVQKCQHHqxEOdh1/JKqJzIyTPLQpqz/Wno0ECqG badger@catamaran"

set -euxo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

for cmd in parted rsync killall readlink mkfs.fat
do
    if ! command -v $cmd >/dev/null 2>&1; then
      echo "Error: Command $cmd not installed.  Exiting." >&2
      exit 1
  fi
done

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# +30% buffer
SIZE_MB=3584
DISK="${SCRIPT_DIR}/arch-mini.raw"
MNT=${1:-/mnt/arch}
FORCE=${2:-0} # allow override of disk skip

if [[ -f $DISK && $FORCE -eq 0 ]]; then
  echo "Warning: $DISK already exists.  Skipping without error."
  exit 0
fi

truncate -s ${SIZE_MB}M "$DISK"

# BIOS-based boot
parted -s "$DISK" mklabel gpt
parted -s "$DISK" mkpart ESP fat32 2MiB 600MiB
parted -s "$DISK" set 1 esp on
parted -s "$DISK" mkpart primary ext4 602MiB 100%

# Setup loop device
LOOPDEV=$(losetup --show -fP "$DISK")  # Maps /dev/loopXp1
sleep 1  # Allow time for partition probing

# Format partition
mkfs.fat -F32 -n ARCH_EFI "${LOOPDEV}p1"
mkfs.ext4 -L ARCH_ROOT "${LOOPDEV}p2"

# loopback the raw partition on mount point
mkdir -p "$MNT/boot/efi"
mount "${LOOPDEV}p2" "$MNT"
mount "${LOOPDEV}p1" "$MNT/boot/efi"

# download and verify
[[ -f archlinux-bootstrap-x86_64.tar.zst ]] || wget https://geo.mirror.pkgbuild.com/iso/latest/archlinux-bootstrap-x86_64.tar.zst
[[ -f sha256sums.txt ]] || wget https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt

grep "$(openssl sha256 -r archlinux-bootstrap-x86_64.tar.zst | awk '{print $1}')" sha256sums.txt
if [ $? -eq 0 ]; then
    echo "Checksum verified successfully!"
else
    echo "Checksum verification failed, refusing to continue without checksums."
    exit 1
fi

[[ -d root.x86_64/ ]] && rm -r root.x86_64/
tar --use-compress-program=unzstd -xvf archlinux-bootstrap-x86_64.tar.zst

# update mirrors, not rerunnable
awk '
/## United States/ {count = 20; next}
count > 0 {
  sub(/^#[ \t]?/, "", $0)
  print
  count--
}' root.x86_64/etc/pacman.d/mirrorlist >> root.x86_64/etc/pacman.d/mirrorlist
# set hostname
echo $INSTANCE_ID > root.x86_64/etc/hostname

# update locales
sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' root.x86_64/etc/locale.gen

# terminal font
echo "FONT=ter-v22b" >> root.x86_64/etc/vconsole.conf

# edit resolv.conf
# start with cloudflare, dhcp may override later
echo nameserver 1.1.1.1 > root.x86_64/etc/resolv.conf

# ssh keys
mkdir -p root.x86_64/root/.ssh/
echo $SSH_KEY > root.x86_64/root/.ssh/authorized_keys
chmod 600 root.x86_64/root/.ssh/authorized_keys

# sync to mount point and prep for grub, etc
rsync -aAXH root.x86_64/ "$MNT"

for i in run proc sys dev
do echo "Mounting $i"
  mount --bind /$i "$MNT/$i"
  mount --make-rslave "$MNT/$i"
done

chroot "$MNT" /bin/bash -c "
    swapoff -a
    ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
    pacman-key --init
    pacman-key --populate archlinux
    locale-gen

    echo LANG=en_US.UTF-8 > /etc/locale.conf

    # install base system
    pacman -Sy --noconfirm base linux terminus-font linux-firmware openssh avahi grub dhcpcd dosfstools efibootmgr os-prober

    mkinitcpio -p linux
    mkdir -p /boot/efi
    mount ${LOOPDEV}p1 /boot/efi
    grub-install --target=x86_64-efi --efi-directory=$MNT/boot/efi --bootloader-id=arch --removable
    grub-mkconfig -o /boot/grub/grub.cfg
    genfstab -U / > /etc/fstab

    echo \"root:root\" | chpasswd

    sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"console=ttyS0\"/' /etc/default/grub
    sed -i 's/^#GRUB_TERMINAL_OUTPUT=.*/GRUB_TERMINAL_OUTPUT=console/' /etc/default/grub

    grub-mkconfig -o /boot/grub/grub.cfg

    systemctl enable dhcpcd sshd avahi-daemon.service

    # install user mode packages
    pacman -Sy --noconfirm \
        man-db \
        eza \
        git \
        nvim \
        htop \
        zsh \
        bat \
        fd \
        dnsutils \
        trash-cli \
        openbsd-netcat \
        gnupg \
        rsync \
        fastfetch \
        git-delta \
        starship \
        fzf \
        which \
        sudo \
        ripgrep \
        lsof \
        psmisc \
        pwgen \
        github-cli

    # FIXME: need a parameterized function for provisioning a user, or use cloud-init
    useradd badger
    usermod -aG wheel badger
    mkdir -p /home/badger/.ssh
    mkdir -p /home/badger/src
    git clone https://github.com/BlueTufa/dotfiles.git /home/badger/src/dotfiles

    echo \"$SSH_KEY\" > /home/badger/.ssh/authorized_keys
    chown -R badger:badger /home/badger
    chmod 700 /home/badger/.ssh
    chmod 600 /home/badger/.ssh/authorized_keys
    sed -i 's/^#\s*\(%wheel ALL=(ALL:ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers
    chsh -s $(which zsh) badger
"

# sleep 10
# killall gpg-agent

# umount -R "$MNT"
# losetup -d "$LOOPDEV"
