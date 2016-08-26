# Scratch-OS
This is a repository for a simple, scratch-work operating system I am building for fun right now.

## Sources

#### OSDev:
* I started off by following the OSDEV tutorial labeled "BareBones". This can be found here:
[BareBones OS Tutorial](http://wiki.osdev.org/Bare_Bones)
This tutorial is
 * This requires you to have a cross compiler installed, and this tutorial can be found here:
 [Building a GCC 4.9 Cross Compiler](http://wiki.osdev.org/User:Max/Building_a_GCC_4.9_cross_compiler_on_OS_X_Mavericks)

	These will be explained in the below section as well.

## Dependencies

1. GNU Cross-Compiler i386-elf-gcc must first be installed on system
* This allows for cross compilation on Target platform
* This can be done at: http://wiki.osdev.org/User:Max/Building_a_GCC_4.9_cross_compiler_on_OS_X_Mavericks

brew tap homebrew/versions
brew install --enable-cxx gcc49
brew install mpfr
brew install gmp
brew install libmpc

export CC=gcc-4.9
export CXX=g++-4.9
export CPP=cpp-4.9
export LD=gcc-4.9

export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

../binutils-2.24/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-werror


make
make install

Create a folder gcc-4.9.0-build in your ~/src folder
cd to that folder
From inside of that folder, we now run the configure script for GCC:
(Note: the configure script might throw an error about not finding the installation of MPC/GMP/MPFR. To make it find these libraries, use the respective "--with-" parameter. When using brew, this is by default "/usr/local", so "--with-gmp=/usr/local" etc. should work)
../gcc-4.9.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
Once the configure script has successfully completed its work, perform the build and installation:
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc


* Automake needed to be added
2. GRUB added:
configure command:  ../../grub/configure --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCONV=i686-elf-objconv TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf
2. Barebones kernel installed

* GRUB../../grub/configure --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCONV=i686-elf-objconv TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf

* TODO: ADD ALOT HERE

## Setup:
TODO:


## Building/Making:
TO BUILD:

qemu-system-i386w.exe -hda <mp3 directory>\mp3.img -m 256 -gdb tcp:127.0.0.1:1234 -S -name

* Using ‘make all’ will build all files in src.
* Using ‘make clean’ will remove all object files and restart building
* Using ‘make dep’ will compile a file with all dependent files.

## Running/Testing
TO RUN:
./test [file_name_relative_to_path]
gdb qemu testing: qemu-system-i386 -cdrom myos.iso-m 256 -gdb tcp:127.0.0.1:1234 -S -name level

got this from ece-391 docs:
test machine: qemu-system-i386 -cdrom myos.iso -m 512 -name test -gdb tcp:127.0.0.1:1234 -S -kernel
devel: qemu-system-i386 -cdrom myos.iso -m 512 -name devel
nodebug: qemu-system-i386 -cdrom myos.iso -m 512 -name test -kernel

GDB:
1. Run: ”$ qemu-system-i386 -s -S myos.iso” on a terminal
2. In a separate terminal open gdb and target port 1234 on localhost.
	- “$ target remote localhost:1234”
3. Continue or proceed to start debugger.
