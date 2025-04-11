#! /bin/bash

export INSTANCE_ID=${1:-"vm-fedora-01"}
export VCPUS=${2:-2}
export MEMORY=${3:-4096}

echo $INSTANCE_ID
echo $VCPUS
echo $MEMORY
# requires install of virt-install, cloud-image-utils, and cloud-init

[[ -f seed.iso ]] && rm seed.iso
cloud-init schema --config-file user-data.yml
cloud-init schema --config-file meta-data.yml
cloud-localds --filesystem=iso9660 seed.iso user-data.yml meta-data.yml

virt-install --name ${INSTANCE_ID} --memory ${MEMORY} --vcpus ${VCPUS} \
   --disk path=/kvmpool/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2,format=qcow2,bus=virtio \
   --disk path=$(pwd)/seed.iso,device=cdrom,bus=sata \
   --os-variant fedora37 \
   --graphics none --import --noautoconsole

