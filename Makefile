
# Makefile for OS project
# To build, first `make dep`, them `make`. Everything should be automatic.
# Will compile all *.c and *.S files in the current directory.


# FLAGS - to use when compiling, preprocessing, assembling, and linking
CFLAGS 	+= -g -std=gnu99 -O2 -Wall -Wextra -fno-builtin -fno-stack-protector  -nostdlib
ASFLAGS += -g
LDFLAGS += -g -O2 -nostdlib

# COMPILERS - Using i686 cross-compiler
CC=i686-elf-gcc
AS=i686-elf-as
LD=i686-elf-ld

# DIRECTORIES - change these to set the proper directories where each files should be
SRCDIR=src
OBJDIR=obj
BINDIR=bin
ISODIR=isodir

# SOURCE - this generates the list of source files
C-SRC := $(wildcard $(SRCDIR)/*.c)
AS-SRC := $(wildcard $(SRCDIR)/*.S)
SRCS := $(C-SRC) $(AS-SRC)

C-OBJS := ${C-SRC:.c=.o}
AS-OBJS := ${AS-SRC:.S=.o}
OBJS := ${C-OBJS} ${AS-OBJS}

# ALL - "make all" compiles all source files into an iso to boot using ./test
# -T = use linking script
# i686-elf-as boot.s -o boot.o
# i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
# i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

all: $(OBJS)
	@echo "Starting Compilation..."
	$(CC) -T src/config/linker.ld -o $(BINDIR)/kernel.elf $(LDFLAGS) $(OBJS)
	@echo "Done Linking..."
	cp $(BINDIR)/kernel.elf isodir/boot/kernel.elf
	@echo "Cleaning Up..."
	cp $(SRCDIR)/*.o $(SRCDIR)/$(OBJDIR)
	rm -f $(SRCDIR)/*.o
	@echo "Creating ISO..."
	grub-mkrescue -o scratch-os.iso $(ISODIR)
	@echo "ISO created. Boot with QEMU."



boot.o: src/boot.S
	$(AS) src/boot.S $(ASFLAGS)
	@echo "Making boot.o ......."

x86_desc.o: src/x86_desc.S
	$(AS) src/x86_desc.S $(ASFLAGS)
	@echo "Making x86_desc.o ......."

kernel.o: src/kernel.c src/test.c
	$(CC) -c src/kernel.c $(CFLAGS)
	@echo "Making kernel.o ......."

test.o: src/test.c
	$(CC) -c src/test.c $(CFLAGS)
	@echo "Making test.o ......."

gdb:
	i686-elf-objcopy --only-keep-debug $(BINDIR)/kernel.elf kernel.sym
	i686-elf-objcopy --strip-debug $(BINDIR)/kernel.elf
	@echo "Debugging files created."

# DEPENDENCIES - "make dep" compiles all dependencies into single makefile.dep file
dep: Makefile.dep

Makefile.dep: $(SRC)
	$(CC) -MM $(CFLAGS) $(SRCS) > $@
	@echo "Dependencies file created..."


# CLEAN - "make clean" - removes all object files and restores settings on make
.PHONY: clean
clean:
	rm -f $(OBJDIR)/*.o Makefile.dep scratch-os

ifneq ($(MAKECMDGOALS),dep)
ifneq ($(MAKECMDGOALS),clean)
include Makefile.dep
endif
endif
