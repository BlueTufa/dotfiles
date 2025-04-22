#! /bin/bash

# requires install of virt-install, cloud-image-utils, and cloud-init

echo "Starting..."
set -euo pipefail

INSTANCE_ID=${1:-"vm-deb-01"}
VCPUS=${2:-2}
MEMORY=${3:-4096}
VERSION=${4:-12}
NAME=${5:-bookworm}
ARCH="amd64"

MEDIA_DIR=${5:-"/media/isos"}
SCRIPTS_DIR=${6:-"/kvmpool/scripts"}
INSTALL_DIR=${7:-"/kvmpool/images"}

BASE_URL="https://cdimage.debian.org/images/cloud/${NAME}/latest"

IMAGE_NAME="debian-${VERSION}-generic-${ARCH}.qcow2"
CHECKSUM_FILE="SHA512SUMS"

download-trixie() {
  echo "Downloading ISO and checksum file..."
  echo "Debian image name: $IMAGE_NAME"
  echo "Debian checksum file: $CHECKSUM_FILE"

  curl -vLo "$MEDIA_DIR/$IMAGE_NAME" "${BASE_URL}/${IMAGE_NAME}"
  curl -vLo "$MEDIA_DIR/$CHECKSUM_FILE" "${BASE_URL}/${CHECKSUM_FILE}"

  echo "Verifying ISO checksum..."
  grep "$(openssl sha256 -r ${IMAGE_NAME} | awk '{print $1}')" "${MEDIA_DIR}/${CHECKSUM_FILE}"
  if [ $? -eq 0 ]; then
      echo "Checksum verified successfully!"
  else
      echo "Checksum verification failed, refusing to continue without checksums."
      exit 1
  fi
}

if [[ ! -f "${MEDIA_DIR}/$IMAGE_NAME" ]]; then
  download-trixie
fi

TARGET_IMAGE=/kvmpool/images/Debian-${VERSION}-${INSTANCE_ID}.qcow2
cp -f ${MEDIA_DIR}/${IMAGE_NAME} ${TARGET_IMAGE}

run-virt-install() {
  echo "Creating a new instance named ${INSTANCE_ID} with ${VCPUS} VCPU and ${MEMORY} RAM"
  cd $SCRIPTS_DIR
  [[ -f seed.iso ]] && rm seed.iso
  [[ -f user-data.named.yml ]] && rm user-data.named.yml
  [[ -f meta-data.named.yml ]] && rm meta-data.named.yml

  cloud-init schema --config-file user-data.yml
  cloud-init schema --config-file meta-data.yml
  /bin/cat user-data.yml | sed "s/\${INSTANCE_ID}/${INSTANCE_ID}/g" > user-data.named.yml
  /bin/cat meta-data.yml | sed "s/\${INSTANCE_ID}/${INSTANCE_ID}/g" > meta-data.named.yml

  cloud-localds --filesystem=iso9660 seed.iso user-data.named.yml meta-data.named.yml

  virt-install --name ${INSTANCE_ID} --memory ${MEMORY} --vcpus ${VCPUS} \
     --disk path="${TARGET_IMAGE},format=qcow2,bus=virtio" \
     --os-variant debian11 \
     --disk path=$(pwd)/seed.iso,device=cdrom,bus=sata \
     --graphics none --import
  #--noautoconsole
}

run-virt-install
