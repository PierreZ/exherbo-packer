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

parted "${device}" --script mklabel gpt

# GRUB
parted "${device}"  --script -- mkpart primary 0MB 2MB
parted "${device}"  --script -- name 1 bios_grub
parted "${device}"  --script -- set 1 bios_grub

# BOOT
#parted "${device}"  --script -- mkpart primary ext2 2MB 512MB
#parted "${device}"  --script -- name 2 boot
#parted "${device}"  --script -- set 2 boot on

# Create ext2
#mkfs.ext4 -L "slashboot" "${device}2"

parted "${device}" --script mkpart primary ext4 2MB 100%
parted "${device}"  --script -- name 2 boot
parted "${device}"  --script -- set 2 boot on

mkfs.ext4 -L "rootfs" "${device}2"
parted /dev/vda --script -- print


mount --verbose "${device}2" /mnt

mkdir /mnt/etc

cat <<EOF > /mnt/etc/fstab
# <fs>       <mountpoint>    <type>    <opts>      <dump/pass>
/dev/vda2    /           ext4 defaults    0 0
EOF
