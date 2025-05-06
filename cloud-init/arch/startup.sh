#! /bin/bash

INSTANCE_ID=${1:-"vm-arch-01"}
VCPUS=${2:-2}
MEMORY=${3:-2048}

SOURCE_PATH=${4:-/kvmpool/scripts/arch/arch-mini.raw}
TARGET_PATH=${5:-/kvmpool/images/arch-${INSTANCE_ID}.raw}

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

if [[ ! -f "$SOURCE_PATH" ]]; then
  echo "Error: The source image $SOURCE_PATH does not exist.  Refusing to continue." >&2
  exit 1
fi

if [[ -f "$TARGET_PATH" ]]; then
  echo "Error: The target image already exists.  Refusing to replace." >&2
  exit 1
fi

cp $SOURCE_PATH $TARGET_PATH

virt-install --name ${INSTANCE_ID} --memory ${MEMORY} --vcpus ${VCPUS} \
  --disk path="${TARGET_PATH},format=raw,bus=virtio" \
  --os-variant archlinux \
  --graphics none --console pty,target_type=serial --import --noautoconsole

virsh autostart ${INSTANCE_ID}
