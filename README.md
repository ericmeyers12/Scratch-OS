# Scratch-OS
This is a repository for a simple, scratch-work operating system I am building for fun right now.

## Sources

#### OSDev:
* [BareBones OS Tutorial](http://wiki.osdev.org/Bare_Bones)
* [Building a GCC 4.9 Cross Compiler](http://wiki.osdev.org/User:Max/Building_a_GCC_4.9_cross_compiler_on_OS_X_Mavericks)
* [Kernel Debugging](http://wiki.osdev.org/Kernel_Debugging)

#### Other
* [Installation of i386-elf-gdb](https://icoderme.wordpress.com/2010/05/05/install-i386-elf-gdb-on-mac-os-x/)

## Dependencies

1. GNU Cross-Compiler i686-elf-gcc and binutils
	* This allows for cross compilation on a target platform (we so happen to be compiling onto a i686 32-bit system).
	* binutils gives some pretty powerful binary processing packages that are used later on.
	* This can be done here:
		[Cross Compiler](http://wiki.osdev.org/User:Max/Building_a_GCC_4.9_cross_compiler_on_OS_X_Mavericks)
	* Once this tutorial is completed you can install GRUB on your system according to the next step.

2. GRUB:
	* GRUB is the bootloader for this O.S. and it can be installed according to the following tutorial:
		[GRUB Instructions](http://wiki.osdev.org/GRUB#Installing_GRUB2_on_Mac_OS_X)

3. GDB:
	* GDB must be configured with a target host of i386-elf to avoid any problems
	* Follow this tutorial here: [GDB for i386](https://icoderme.wordpress.com/2010/05/05/install-i386-elf-gdb-on-mac-os-x/)



* TODO: ADD ALOT HERE

## Building/Making:

##### To Build:
* Using ‘make all’ will build all files in src.
* Using ‘make gdb’ will generate all symbol-files needed for debugging.
* Using ‘make clean’ will remove all object files and restart building
* Using ‘make dep’ will compile a file with all dependent files.

##### To Run:
* Normal Operation:
	./test [file_name_relative_to_path]
* Debugging Operation:
	./test_debug [file_name_relative_to_path]
	This will open up a qemu system that is waiting for any incoming execution.

gdb qemu testing: qemu-system-i386 -cdrom myos.iso-m 256 -gdb tcp:127.0.0.1:1234 -S -name devel

got this from ece-391 docs:
test machine: qemu-system-i386 -cdrom myos.iso -m 512 -name test -gdb tcp:127.0.0.1:1234 -S -kernel
devel: qemu-system-i386 -cdrom myos.iso -m 512 -name devel
nodebug: qemu-system-i386 -cdrom myos.iso -m 512 -name test -kernel

GDB:
1. Run: ”$ qemu-system-i386 -s -S myos.iso” on a terminal
2. In a separate terminal open gdb and target port 1234 on localhost.
	- “$ target remote localhost:1234”
3. Continue or proceed to start debugger.
