#!/bin/bash

set -e
set -x

if [ -e /dev/vda ]; then
  device=/dev/vda
elif [ -e /dev/sda ]; then
  device=/dev/sda
else
  echo "ERROR: There is no disk available for installation" >&2
  exit 1
fi
export device


parted --script "${device}" mklabel msdos
parted --script --align optimal "${device}" mkpart primary btrfs 0% 100%
mkfs.btrfs -L "rootfs" "${device}1"
mount --verbose "${device}1" /mnt

echo "Done."