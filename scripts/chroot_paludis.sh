#!/bin/bash

chroot /mnt /bin/bash -ex<<EOF

cave resolve repository/perl -x1
cave resolve world -c
cave resolve --execute --preserve-world --skip-phase test sys-apps/systemd

EOF