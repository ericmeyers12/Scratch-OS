
# Makefile for OS project
# To build, first `make dep`, them `make`. Everything should be automatic.
# Will compile all *.c and *.S files in the current directory.


# FLAGS - to use when compiling, preprocessing, assembling, and linking
CFLAGS 	+= -std=gnu99 -ffreestanding -O2 -Wall -Wextra
ASFLAGS +=
LDFLAGS += -ffreestanding -O2 -nostdlib

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
AS-SRC =  $(wildcard $(SRCDIR)/*.s)
C-SRC = $(wildcard $(SRCDIR)/*.c)
ALL-SRC = $(C-SRC)
ALL-SRC += $(AS-SRC)

# OBJECTS - this generates the list of object files (from source files)
C-OBJS := ${C-SRC:.c=.o}
AS-OBJS := ${AS-SRC:.s=.o}

# ALL - "make all" compiles all source files into an iso to boot using ./test
# -T = use linking script
all:
	$(AS) -g $(AS-SRC) -o $(AS-OBJS) $(ASFLAGS)
	$(CC) -g -c $(C-SRC) -o $(C-OBJS) $(CFLAGS)
	$(CC) -T $(SRCDIR)/config/linker.ld -o $(BINDIR)/kernel.elf $(LDFLAGS) $(AS-OBJS) $(C-OBJS) -lgcc
	cp $(BINDIR)/kernel.elf isodir/boot/kernel.elf
	grub-mkrescue -o myos.iso $(ISODIR)

gdb:
	i686-elf-objcopy --only-keep-debug $(BINDIR)/kernel.elf kernel.sym
	i686-elf-objcopy --strip-debug $(BINDIR)/kernel.elf

gdb-test:
	i686-elf-objcopy --only-keep-debug $(BINDIR)/kernel.elf kernel.debug
	i686-elf-objcopy --add-gnu-debuglink=kernel.debug $(BINDIR)/kernel.elf
	i686-elf-objdump -s -j .gnu_debuglink $(BINDIR)/kernel.elf


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
