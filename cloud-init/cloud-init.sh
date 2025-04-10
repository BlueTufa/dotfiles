#! /bin/bash

# requires install of virt-install, cloud-image-utils, and cloud-init

#cloud-config
[[ -f seed.iso ]] && rm seed.iso
cloud-init schema --config-file user-data.yml
cloud-init schema --config-file meta-data.yml
cloud-localds --filesystem=iso9660 seed.iso user-data.yml meta-data.yml

virt-install --name fedora-cloud-01 --memory 16384 --vcpus 4 \
   --disk path=/kvmpool/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2,format=qcow2,bus=virtio \
   --disk path=$(pwd)/seed.iso,device=cdrom,bus=sata \
   --os-variant fedora37 \
   --graphics none --import --noautoconsole

