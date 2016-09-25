#!/bin/sh
# To make grub bootable disk image
# 	- must be on a linux machine
# 	- must have dd, fdisk, losetup, mkfs, and grub installed
# 	- must possess grub stage files (including stage 1.5 for FS)
#
dd if=/dev/zero of="$1" count=10080

# fdisk piping magic
echo "\n Now creating partition on image. \n"
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk "$1"
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
	# default - continue till end of disk
  x
  c
  10	# Cylinders
  h
  16	# Heads
  s
  63	# Sections
  i
  83	# Linux identifier
  r
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

losetup -o 1048576 /dev/loop0 "$1"
mkfs.ext2 /dev/loop0

echo "\n Mounting and setting up loopback device. \n"
mount /dev/loop0 /mnt
losetup -d /dev/loop0
mkdir -p /mnt/boot/grub
echo "\n Copying grub files over. \n"
cp grub/stage1 grub/stage2 grub/e2fs_stage1_5 grub/grub.conf grub/menu.lst /mnt/boot/grub
umount /dev/loop0

grub —device-map=/dev/null
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | grub —device-map=/dev/null
	device (hd0) "$1"
	geometry (hd0) 40 16 63
	root (hd0,0)
	setup (hd0)
	quit

echo "\n Created image. \n"
