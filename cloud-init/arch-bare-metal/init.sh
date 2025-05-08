#! /bin/bash

set -eEo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

INSTANCE_ID=${1:-"arch-metal-01"}
SSH_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwt/pVQKCQHHqxEOdh1/JKqJzIyTPLQpqz/Wno0ECqG badger@catamaran"
MNT=/mnt/arch

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
sudo sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' root.x86_64/etc/locale.gen

# terminal font
echo "FONT=ter-v22b" >> root.x86_64/etc/vconsole.conf

# edit resolv.conf
# start with cloudflare, dhcp may override later
echo nameserver 1.1.1.1 > root.x86_64/etc/resolv.conf

# ssh keys
# mkdir -p root.x86_64/root/.ssh/
# echo $SSH_KEY > root.x86_64/root/.ssh/authorized_keys
# chmod 600 root.x86_64/root/.ssh/authorized_keys

sudo mkdir -p root.x86_64/etc/systemd/network

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

chroot "$MNT" /bin/bash -c "
    swapoff -a
    ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
    pacman-key --init
    pacman-key --populate archlinux
    locale-gen

    echo LANG=en_US.UTF-8 > /etc/locale.conf

    # install base system
    pacman -Sy --noconfirm base linux terminus-font linux-firmware dhcpcd openssh avahi grub os-prober efibootmgr

    mkinitcpio -p linux
    genfstab -U / > /etc/fstab

    echo \"root:root\" | chpasswd

    systemctl enable dhcpcd systemd-networkd sshd avahi-daemon.service

    # install user mode packages
    pacman -Sy --noconfirm man-db eza git nvim htop zsh bat dnsutils trash-cli openbsd-netcat gnupg rsync fastfetch git-delta starship fzf which sudo
    # install dev tools
    pacman -Sy --noconfirm base-devel linux-headers

    # optional: nvidia / yubikey hardware
    # pacman -Sy cuda \
    #   nvidia \
    #   nvidia-settings \
    #   nvidia-utils \
    #   nvtop \
    #   yubikey-manager \
    #   yubikey-personalization

    useradd badger
    usermod -aG wheel badger
    mkdir -p /home/badger/.ssh
    echo $SSH_KEY > /home/badger/.ssh/authorized_keys
    chown -R badger:badger /home/badger
    chmod 700 /home/badger/.ssh
    chmod 600 /home/badger/.ssh/authorized_keys
    sed -i 's/^#\s*\(%wheel ALL=(ALL:ALL) NOPASSWD: ALL\)/\1/' /etc/sudoers
"

# install EFI grub manually
