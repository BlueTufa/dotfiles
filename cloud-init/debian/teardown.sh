#! /bin/bash
INSTANCE_ID=${1:-"vm-deb-01"}
# quickly tear down the instances that didn't work
virsh destroy ${INSTANCE_ID}
# the assumption is that if you're calling this, you no longer care about the snapshots
for snap in $(virsh snapshot-list "$INSTANCE_ID" --name); do virsh snapshot-delete "$INSTANCE_ID" --snapshotname "$snap"; done
virsh undefine ${INSTANCE_ID} --remove-all-storage
