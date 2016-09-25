#!/bin/sh

umount /mnt/tmpdir
cp -f /tmp/dir/scratch-os.img ./
rm -rf /tmp/dir
rmdir /mnt/tmpdir
