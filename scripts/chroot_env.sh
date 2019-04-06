#!/bin/bash

chroot /mnt /bin/bash -ex<<EOF
echo LANG="en_US.UTF-8" > /etc/env.d/99locale
localedef -i en_US -f UTF-8 en_US.UTF-8
source /etc/profile

cave sync

EOF