#!/bin/bash

chroot /mnt /bin/bash -ex<<EOF
git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git --depth 1 -b v$KERNEL /usr/src/linux
cd /usr/src/linux

make HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu- mrproper
yes "" | make HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu- x86_64_defconfig
yes "" | make HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu- kvmconfig

# Enable /proc/config.gz support
sed -i -e 's/.*CONFIG_IKCONFIG[= ].*/CONFIG_IKCONFIG=y/' .config
echo 'CONFIG_IKCONFIG_PROC=y' >> .config

# Enable btrfs support
sed -i -e 's/# CONFIG_BTRFS_FS is not set/CONFIG_BTRFS_FS=y/g' .config
echo -e "CONFIG_BTRFS_FS_POSIX_ACL=y" >> .config
echo -e "# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set" >> .config
echo -e "# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set" >> .config
echo -e "# CONFIG_BTRFS_DEBUG is not set" >> .config
echo -e "# CONFIG_BTRFS_ASSERT is not set" >> .config

make -j8 HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu-
echo "make done"

make -j8 modules HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu- || die "Building modules failed."
echo "make modules done"

make -j8 install HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu- || die "Installing kernel failed."
echo "make install done"

make -j8 modules_install HOSTCC=x86_64-pc-linux-gnu-gcc CROSS_COMPILE=x86_64-pc-linux-gnu- || die "Installing modules failed."
echo "make modules_install done"

EOF