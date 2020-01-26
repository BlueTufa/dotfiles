# Installing a new arch instance from an existing instance without the installation media

# init a new bare install (no arch install media)
cd /mnt/newdrive
_ mkdir -m 0555 -p {proc,dev}
_ mkdir -m 1777 -p tmp
_ mkdir -m 0755 -p var/log
_ mkdir -m 0755 -p var/{cache/pacman/pkg,lib/pacman} run

# mount the existing system devices as a prerequisite to chroot:
_ pacman -r /mnt/newdrive -Sy pacman
_ pacman -r /mnt/newdrive -Sy neovim
_ mount -o bind /dev /mnt/newdrive/dev/
_ mount -t proc /proc /mnt/newdrive/proc/
_ mount -t sysfs /sys /mnt/newdrive/sys/
# important for EFI and GRUB!
_ mount --make-rslave --rbind /sys sys

# then, chroot /mnt/newdrive
add nameserver to resolv.conf
pacman-key --init
pacman-key --populate archlinux
# this step is super important
for EFI, mount /boot to EFI system partition
edit the mirror list for pacman
pacman -Sy linux linux-firmware efibootmgr
ln -s /usr/bin/nvim /usr/bin/vi
ln -s /usr/bin/nvim /usr/bin/vim
ln -s /usr/share/zoneinfo/America/Denver /etc/localtime
       │ File: /etc/systemd/network/eno2.network
   1   │ [Match]
   2   │ Name=eno2
   3   │ 
   4   │ [Network]
   5   │ DHCP=true
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch-kde
edit /etc/fstab
edit and run locale-gen
console font
time zone
/etc/localtime to /usr/share/zoneinfo/America/Denver
/etc/vconsole.conf
FONT=/usr/share/kbd/consolefonts/ter-228b.psf.gz
useradd -G users -d /home/badger/ -s /usr/bin/fish badger
passwd badger

# change root password
# add badger to sudoers

installed packages thus far:
   43  pacman -Sy base
   44  pacman -Sy linux linux-firmware efibootmgr
   81  pacman -S grub
  116  pacman -S terminus-font
  137  pacman -S sudo
  140  pacman -S fish
  141  pacman -S which

# very important!
Don't forget to run grub_mkconfig before reboot!
