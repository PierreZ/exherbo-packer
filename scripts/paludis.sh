#!/bin/bash

ls /mnt/etc/paludis

cat <<EOF > /mnt/etc/paludis/options.conf
*/* build_options: jobs=7
*/* targets: i686-pc-linux-gnu
*/* btrfs dbus man-pages
EOF