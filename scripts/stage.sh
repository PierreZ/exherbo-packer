#!/bin/bash

set -e;
set -x;

cd /mnt

curl -O http://dev.exherbo.org/stages/exherbo-x86_64-pc-linux-gnu-current.tar.xz
curl -O http://dev.exherbo.org/stages/sha1sum
grep exherbo-x86_64-pc-linux-gnu-current.tar.xz sha1sum | sha1sum -c
tar xJpf exherbo*xz

cat <<EOF > /mnt/etc/fstab
# <fs>       <mountpoint>    <type>    <opts>      <dump/pass>
/dev/vda1    /           btrfs defaults    0 0
EOF

cp /etc/resolv.conf /mnt/etc/resolv.conf