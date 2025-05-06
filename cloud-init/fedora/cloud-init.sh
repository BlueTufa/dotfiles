#! /bin/bash

# requires install of virt-install, cloud-image-utils, and cloud-init

echo "Starting..."
set -euo pipefail

INSTANCE_ID=${1:-"vm-fedora-01"}
VCPUS=${2:-2}
MEMORY=${3:-4096}
FEDORA_VERSION=${4:-41}
MEDIA_DIR=${5:-"/media/isos"}
SCRIPTS_DIR=${6:-"/kvmpool/scripts/fedora"}
INSTALL_DIR=${7:-"/kvmpool/images"}

ARCH="x86_64"
ISO_TYPE="Cloud"
BASE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/${FEDORA_VERSION}/${ISO_TYPE}/${ARCH}/images"
echo $BASE_URL
IMAGE_NAME=$(curl -sL "${BASE_URL}/" | \
  grep -E "Fedora-${ISO_TYPE}-Base-Generic-${FEDORA_VERSION}-1\.[0-9]+\.${ARCH}\.qcow2" | \
  sed -nE "s/.*(Fedora-${ISO_TYPE}-Base-Generic-${FEDORA_VERSION}-1\.[0-9]+\.${ARCH}\.qcow2).*/\1/p" | sort -V | tail -n 1)
if [[ -z "$IMAGE_NAME" ]]; then
  echo "Could not find a valid qcow for the requested release. Check the BASE_URL or network."
  exit 1
fi

echo "Fedora image name: $IMAGE_NAME"

CHECKSUM_FILE=$(curl -sL "${BASE_URL}/" | \
  grep -E "Fedora-${ISO_TYPE}-${FEDORA_VERSION}-1\.[0-9]+\-${ARCH}-CHECKSUM" | \
  sed -nE "s/.*(Fedora-${ISO_TYPE}-${FEDORA_VERSION}-1\.[0-9]+\-${ARCH}-CHECKSUM).*/\1/p" | sort -V | tail -n 1)
if [[ -z $CHECKSUM_FILE ]]; then
  echo "Could not find a valid checksum file.  Refusing to continue without checksums."
  exit 2
fi

echo "Fedora checksum file: $CHECKSUM_FILE"

echo "Creating a new instance named ${INSTANCE_ID} with ${VCPUS} VCPU and ${MEMORY} RAM"

download-fedora() {
  echo "Downloading ISO and checksum file..."
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
  download-fedora
fi

TARGET_IMAGE=/kvmpool/images/Fedora-Cloud-${INSTANCE_ID}.qcow2
cp -f ${MEDIA_DIR}/${IMAGE_NAME} ${TARGET_IMAGE}

run-virt-install() {
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
     --disk path=$(pwd)/seed.iso,device=cdrom,bus=sata \
     --os-variant fedora37 \
     --graphics none --import --noautoconsole

  virsh autostart ${INSTANCE_ID}
}

run-virt-install
