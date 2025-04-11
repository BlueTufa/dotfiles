#! /bin/bash

export INSTANCE_ID=${1:-"vm-fedora-01"}
export VCPUS=${2:-2}
export MEMORY=${3:-4096}

echo "Creating a new instance named ${INSTANCE_ID} with ${VCPUS} VCPU and ${MEMORY} RAM"
# requires install of virt-install, cloud-image-utils, and cloud-init

[[ -f seed.iso ]] && rm seed.iso
[[ -f user-data.named.yml ]] && rm  user-data.named.yml
[[ -f meta-data.named.yml ]] && rm  meta-data.named.yml

cloud-init schema --config-file user-data.yml
cloud-init schema --config-file meta-data.yml
/bin/cat user-data.yml | sed "s/\${INSTANCE_ID}/${INSTANCE_ID}/g" > user-data.named.yml
/bin/cat meta-data.yml | sed "s/\${INSTANCE_ID}/${INSTANCE_ID}/g" > meta-data.named.yml

cloud-localds --filesystem=iso9660 seed.iso user-data.named.yml meta-data.named.yml

virt-install --name ${INSTANCE_ID} --memory ${MEMORY} --vcpus ${VCPUS} \
   --disk path=/kvmpool/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2,format=qcow2,bus=virtio \
   --disk path=$(pwd)/seed.iso,device=cdrom,bus=sata \
   --os-variant fedora37 \
   --graphics none --import --noautoconsole

