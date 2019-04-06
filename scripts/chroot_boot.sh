#!/bin/bash

chroot /mnt /bin/bash -ex<<EOF

grub-install /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg
cat /boot/grub/grub.cfg

EOF
# bootctl install
# grub-mkconfig -o /boot/grub/grub.cfg

#bootctl --path=/boot install
#kernel-install add linux-$KERNEL /boot/vmlinuz-linux