#! /bin/bash

INSTANCE_ID=${1:-"vm-arch-01"}
SSH_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwt/pVQKCQHHqxEOdh1/JKqJzIyTPLQpqz/Wno0ECqG badger@catamaran"

set -euxo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

SIZE_MB=5120
DISK=arch-mini.raw
MNT=/mnt/arch

if [[ -f $DISK ]]; then
  echo "Warning: $DISK already exists.  Skipping without error."
  exit 0
fi

for cmd in parted rsync killall
do
    if ! command -v $cmd >/dev/null 2>&1; then
      echo "Error: Command $cmd not installed.  Exiting." >&2
      exit 1
  fi
done

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

# download
[[ -f archlinux-bootstrap-x86_64.tar.zst ]] || wget https://geo.mirror.pkgbuild.com/iso/latest/archlinux-bootstrap-x86_64.tar.zst
[[ -f sha256sums.txt ]] || wget https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt

grep "$(openssl sha256 -r archlinux-bootstrap-x86_64.tar.zst | awk '{print $1}')" sha256sums.txt
if [ $? -eq 0 ]; then
    echo "Checksum verified successfully!"
else
    echo "Checksum verification failed, refusing to continue without checksums."
    exit 1
fi

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

mkdir -p root.x86_64/etc/systemd/network

IF_NAME=$(ls /sys/class/net/ | grep '^en')
echo cat <<-EOF > root.x86_64/etc/systemd/network/20-wired.network
[Match]
Name=$IF_NAME

[Network]
DHCP=yes
EOF

rsync -aAXH root.x86_64/ "$MNT"

for i in run proc sys dev
do echo "Mounting $i"
  mount --bind /$i "$MNT/$i"
  mount --make-rslave "$MNT/$i"
done

# FIXME:
# pacman -Sy efibootmgr cloud-init
chroot "$MNT" /bin/bash -c "
    swapoff -a
    ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
    pacman-key --init
    pacman-key --populate archlinux
    locale-gen

    echo LANG=en_US.UTF-8 > /etc/locale.conf

    # install base system
    pacman -Sy --noconfirm base linux terminus-font linux-firmware dhcpcd openssh avahi grub os-prober

    mkinitcpio -p linux
    genfstab -U / > /etc/fstab
    grub-install --target=i386-pc --recheck $LOOPDEV
    grub-mkconfig -o /boot/grub/grub.cfg

    echo \"root:root\" | chpasswd

    sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"console=ttyS0\"/' /etc/default/grub
    sed -i 's/^#GRUB_TERMINAL_OUTPUT=.*/GRUB_TERMINAL_OUTPUT=console/' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg

    systemctl enable dhcpcd systemd-networkd sshd avahi-daemon.service

    # install user mode packages
    pacman -Sy --noconfirm \
        man-db \
        eza \
        git \
        nvim \
        htop \
        zsh \
        bat \
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
    echo \"$SSH_KEY\" > /home/badger/.ssh/authorized_keys
    chown -R badger:badger /home/badger
    chmod 700 /home/badger/.ssh
    chmod 600 /home/badger/.ssh/authorized_keys
    sed -i 's/^#\s*\(%wheel ALL=(ALL:ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers
"

sleep 10
killall gpg-agent

umount -R "$MNT"
losetup -d "$LOOPDEV"
