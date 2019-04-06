#!/bin/bash

mount -o rbind /dev /mnt/dev/
mount -o bind /sys /mnt/sys/
mount -t proc none /mnt/proc/

cat <<EOF > /mnt/etc/paludis/options.conf
*/* build_options: jobs=7
*/* targets: i686-pc-linux-gnu
*/* btrfs dbus man-pages xattr
EOF