#! /bin/bash
INSTANCE_ID=${1:-"vm-deb-01"}
# quickly tear down the instances that didn't work
virsh destroy ${INSTANCE_ID}
virsh undefine ${INSTANCE_ID} --remove-all-storage
