
# Makefile for OS project
# To build, first `make dep`, them `make`. Everything should be automatic.
# Will compile all *.c and *.S files in the current directory.

#qemu-system-i386 -cdrom myos.iso-m 256 -gdb tcp:127.0.0.1:1234 -S -name level
#i686-elf-as src/boot.s -o build/boot.o
#i686-elf-gcc -g -c src/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
#i686-elf-gcc -T src/config/linker.ld -g -o build/myos.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc


# FLAGS - to use when compiling, preprocessing, assembling, and linking
CFLAGS 	+= -std=gnu99 -ffreestanding -O2 -Wall -Wextra -fno-builtin -fno-stack-protector -nostdlib
ASFLAGS +=
LDFLAGS += -ffreestanding -O2 -nostdlib -static

# COMPILERS - Using i686 cross-compiler
CC=i686-elf-gcc
AS=i686-elf-as

# DIRECTORIES - change these to set the proper directories where each files should be
SRCDIR=src
OBJDIR=obj
BINDIR=bin

# This generates the list of source files
AS-SRC =  $(wildcard $(SRCDIR)/*.s)
C-SRC = $(wildcard $(SRCDIR)/*.c)
ALL-SRC = $(C-SRC)
ALL-SRC += $(AS-SRC)


C-OBJS := ${C-SRC:.c=.o} 
AS-OBJS := ${AS-SRC:.s=.o}


all:
	$(AS) $(AS-SRC) -o $(AS-OBJS)
	$(CC) -c $(C-SRC) -o $(C-OBJS) $(CFLAGS)
	$(CC) -T $(SRCDIR)/config/linker.ld -g -o $(BINDIR)/myos.bin $(LDFLAGS) $(AS-OBJS) $(C-OBJS) -lgcc
	cp $(BINDIR)/myos.bin isodir/boot/myos.bin
	grub-mkrescue -o myos.iso isodir



# DEPENDENCIES - "make dep" compiles all dependencies into single makefile.dep file
dep: Makefile.dep

Makefile.dep: $(ALL-SRC)
	$(CC) -MM $(CFLAGS) $(ALL-SRC) > $@
	@echo "Dependencies file created."


# CLEAN - "make clean" - removes all object files and restores settings on make
.PHONY: clean
clean:
	rm -f $(OBJDIR)/*.o Makefile.dep scratch-os

ifneq ($(MAKECMDGOALS),dep)
ifneq ($(MAKECMDGOALS),clean)
include Makefile.dep
endif
endif
