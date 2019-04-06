#!/bin/bash

set -e;
set -x;

cd /mnt

curl -O http://dev.exherbo.org/stages/exherbo-x86_64-pc-linux-gnu-current.tar.xz
curl -O http://dev.exherbo.org/stages/sha1sum
grep exherbo-x86_64-pc-linux-gnu-current.tar.xz sha1sum | sha1sum -c
tar xJpf exherbo*xz

cp /etc/resolv.conf /mnt/etc/resolv.conf