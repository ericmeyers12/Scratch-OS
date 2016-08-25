# Scratch-OS
This is a repository for a simple, scratch-work operating system I am building for fun right now.


Pre-Requisites:

1. GNU Cross-Compiler i386-elf-gcc must first be installed on system 
	- This allows for cross compilation on Target platform 
	- This can be done at: http://wiki.osdev.org/User:Max/Building_a_GCC_4.9_cross_compiler_on_OS_X_Mavericks
	- Automake needed to be added
2. GRUB added: 
configure command:  ../../grub/configure --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCONV=i686-elf-objconv TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf
2. Barebones kernel installed


GRUB../../grub/configure --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCONV=i686-elf-objconv TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf

TO BUILD:

qemu-system-i386w.exe -hda <mp3 directory>\mp3.img -m 256 -gdb tcp:127.0.0.1:1234 -S -name

i686-elf-as src/boot.s -o build/boot.o
i686-elf-gcc -g -c src/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T src/config/linker.ld -g -o build/myos.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc
cp build/myos.bin isodir/boot/myos.bin
grub-mkrescue -g -o myos.iso isodir

TO RUN:
qemu-system-i386 -cdrom myos.iso-m 256 -gdb tcp:127.0.0.1:1234 -S -name level

test machine: qemu-system-i386 -cdrom myos.iso -m 512 -name test -gdb tcp:127.0.0.1:1234 -S -kernel
devel: qemu-system-i386 -cdrom myos.iso -m 512 -name devel
nodebug: qemu-system-i386 -cdrom myos.iso -m 512 -name test -kernel

GDB:
1. Run: ”$ qemu-system-i386 -s -S myos.iso” on a terminal
2. In a separate terminal open gdb and target port 1234 on localhost.
	- “$ target remote localhost:1234”
3. Continue or proceed to start debugger.

