#!/bin/sh

if [ -d /mnt/tmpdir ]; then
rm -rf /mnt/tmpdir
fi

if [ -d /tmp/dir ]; then
rm -rf /tmp/dir
fi

mkdir /mnt/tmpdir
mkdir /tmp/dir
cp ./bootimg /tmp/dir/
cp ./filesys_img /tmp/dir/
cp ./scratch-os.img /tmp/dir/
mount -o loop,offset=1048576 /tmp/dir/scratch-os.img /mnt/tmpdir
cp -f /tmp/dir/bootimg /mnt/tmpdir/
cp -f /tmp/dir/filesys_img /mnt/tmpdir/

#

#umount /mnt/tmpmp3
#cp -f /tmp/mp3/mp3.img ./
#rm -rf /tmp/mp3
#rmdir /mnt/tmpmp3
