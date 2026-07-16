#! /bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script as root or using sudo." >&2
    exit 1
fi

# gen a 256 bit key for AES use
tpm2_getrandom 32 | xxd -p -c 256 > secret.bin

tpm2_createprimary -C o -c primary.ctx

tpm2_create \
    -C primary.ctx \
    -i secret.bin \
    -u secret.pub \
    -r secret.priv

tpm2_load \
    -C primary.ctx \
    -u secret.pub \
    -r secret.priv \
    -c secret.ctx

shred --exact secret.bin

cp secret.pub /etc/initcpio/hooks/
cp secret.priv /etc/initcpio/hooks/
