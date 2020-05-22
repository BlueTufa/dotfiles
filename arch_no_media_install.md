# Installing a new arch instance from an existing instance without the installation media
I had an epiphany that if you are already running Arch, you can install Arch on a new drive using your current installation as a baseline instead of using bootable media.  This basically works through a combination of 3 concepts: 
1.  pacman will allow you to specify a target install location via the -r argument.  Doing so will allow you install pacman on a clean drive.
2.  Using the mount command to mount `proc` and `sys`, etc.
3.  Switching to the new drive via chroot.  The key difference between chroot and arch-chroot is that arch-chroot does step #2 for you.

---
NOTE: in the examples below, `_` is aliased to `sudo`.
---

I have been running with this configuration for several months now, and reguarly pull in rolling updates via `pacman -Syu` and have yet to encounter a single difference between this manual installation process and an install media-based installation.  It is after all, just an extension of the already minimalist Arch installation process.  I actually find this approach more confidence inspiring and more deterministic than booting from installation media.  In theory you might be able to use some other distro as a baseline, but you're likely to have problems installing pacman.  If you figure out a way let me know.  

### init a new bare install (no arch install media)
In this scenario, you have already formatted and mounted /mnt/newdrive as a blank ext4 disk.  These steps are performed for you by the pacman-bootstrap script that is present on the installation media.
```bash
cd /mnt/newdrive
_ mkdir -m 0555 -p {proc,dev}
_ mkdir -m 1777 -p tmp
_ mkdir -m 0755 -p var/log
_ mkdir -m 0755 -p var/{cache/pacman/pkg,lib/pacman} run
```

### mount the existing system devices as a prerequisite to chroot:
Here, you are installing pacman, and optional but highly recommended, some sort of text editor to allow you to edit config files from the new root.
```bash
_ pacman -r /mnt/newdrive -Sy pacman
_ pacman -r /mnt/newdrive -Sy neovim
_ mount -o bind /dev /mnt/newdrive/dev/
_ mount -t proc /proc /mnt/newdrive/proc/
_ mount -t sysfs /sys /mnt/newdrive/sys/
# important for EFI and GRUB!
_ mount --make-rslave --rbind /sys sys
```

### NEXT
```bash
chroot /mnt/newdrive
```

You can see that the devices are properly mounted by simply running `cat /proc/cpuinfo` etc.  

* add nameserver to resolv.conf
`vi /etc/resolv.conf`
`nameserver 1.1.1.1`

* You need to initialize the pacman keyring for the arch repos
```bash
pacman-key --init
pacman-key --populate archlinux
```

### this step is super important
* for EFI, mount /boot to EFI system partition.  Don't forget to add this to your fstab or you'll have upgrade problems.
* edit the mirror list for pacman
* install the kernel and efi packages 
```bash
pacman -Sy linux linux-firmware efibootmgr
ln -s /usr/bin/nvim /usr/bin/vi
ln -s /usr/bin/nvim /usr/bin/vim
```
* Next, you will need to configure networking.  It is extremely important than you remember to install `dhcpcd` later or you will spend a bunch of time rebooting and reconfiguring to get networking to work later.  Or you can temporarily put in a static IP address if you have one.
```bash
sudo ip link show
```
Extract the name of the network interface that you would like to use and add it to the config file below, for example, `en02`
```bash
sudo pacman -S dhcpcd
vi File: /etc/systemd/network/eno2.network
 [Match]
 Name=eno2
 
 [Network]
 DHCP=true
```
# Grub installation.  
This is probably the most difficult and error-prone step of any Arch Linux install.  This and dhcpcd configuration also require the most reboots / media boots to get corrected and tested.  
Remember when editing /etc/fstab that if you don't include the /boot directory in your mount points, future kernel updates will fail.
```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch-kde
edit /etc/fstab
```
Other tasks.  These are well documented in the Arch Linux wiki
* edit and run locale-gen
* console font
* time zone
* /etc/localtime to /usr/share/zoneinfo/America/Denver
* `ln -s /usr/share/zoneinfo/America/Denver /etc/localtime`
* `vi /etc/vconsole.conf`
* FONT=/usr/share/kbd/consolefonts/ter-228b.psf.gz # TODO: that font is way too big even @ 4K
* useradd -G users -d /home/badger/ -s /usr/bin/fish badger
* passwd badger

* change root password
* add badger to sudoers

installed packages thus far:
```bash
  pacman -Sy base
  pacman -Sy linux linux-firmware efibootmgr
  pacman -S grub
  pacman -S terminus-font
  pacman -S sudo
  pacman -S fish
  pacman -S which
  pacman -S dhcpcd 
```

# very important!
Don't forget to run grub_mkconfig before reboot!
