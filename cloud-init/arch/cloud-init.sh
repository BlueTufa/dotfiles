#! /bin/bash

set -eEo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

INSTANCE_ID=${1:-"vm-arch-01"}
# assumes you have an ext4 file system mounted at `/mnt/arch`

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

# edit resolv.conf
echo nameserver 192.168.160.1 > root.x86_64/etc/resolv.conf

# ssh keys
mkdir -p root.x86_64/root/.ssh/
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwt/pVQKCQHHqxEOdh1/JKqJzIyTPLQpqz/Wno0ECqG badger@catamaran" > root.x86_64/root/.ssh/authorized_keys
chmod 600 root.x86_64/root/.ssh/authorized_keys

sudo mkdir -p root.x86_64/etc/systemd/network

echo "PARTUUID=$(blkid -s UUID -o value $(blkid -L ARCH_ROOT)) / ext4 rw,discard,errors=remount-ro,x-systemd.growfs 0" > root.x86_64/etc/fstab
echo "PARTUUID=496f5cff-54c3-4015-942d-81bd87545779 /boot/efi vfat defaults 0 0" >> root.x86_64/etc/fstab

IF_NAME=$(ls /sys/class/net/ | grep '^en')
echo cat <<-EOF > root.x86_64/etc/systemd/network/20-wired.network
[Match]
Name=$IF_NAME

[Network]
DHCP=yes
EOF

rsync -aAXH root.x86_64/ /mnt/arch/

for i in run proc sys dev
do echo "Mounting $i"
  mount --make-rprivate /$i
  mount --bind /$i /mnt/arch/$i
done

chroot /mnt/arch /bin/bash -c "
    ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
    pacman-key --init
    pacman-key --populate archlinux
    locale-gen
    echo LANG=en_US.UTF-8 > /etc/locale.conf

    pacman -Sy --noconfirm base linux linux-firmware efibootmgr
    pacman -Sy --noconfirm dhcpcd openssh

    systemctl enable dhcpcd
    systemctl enable systemd-networkd
    systemctl enable sshd
"
