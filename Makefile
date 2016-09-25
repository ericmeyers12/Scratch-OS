
# Makefile for OS project
# To build, first `make dep`, them `make`. Everything should be automatic.
# Will compile all *.c and *.S files in the current directory.


# Flags to use when compiling, preprocessing, assembling, and linking
CFLAGS 	+= -g -Wall -fno-builtin -fno-stack-protector -nostdlib -O0
ASFLAGS += -g -O0
LDFLAGS += -nostdlib -static

# CROSS-COMPILERS - i686-elf to
AS=i686-elf-as
CC=i686-elf-gcc
LD=i686-elf-ld

# DIRECTORIES - change these to set the proper directories where each files should be
SRCDIR=src
OBJDIR=obj
BINDIR=bin
ISODIR=isodir


# This generates the list of source files
SRC =  $(wildcard $(SRCDIR)/*.S) $(wildcard $(SRCDIR)/*.c)

# This generates the list of .o files. The order matters, boot.o must be first
OBJS  = $(SRCDIR)/boot.o
OBJS += $(filter-out $(SRCDIR)/boot.o,$(patsubst $(SRCDIR)/%.S,$(SRCDIR)/%.o,$(filter $(SRCDIR)/%.S,$(SRC))))
OBJS += $(patsubst $(SRCDIR)/%.c,$(SRCDIR)/%.o,$(filter $(SRCDIR)/%.c,$(SRC)))


bootimg: Makefile $(OBJS)
	@echo "\nLinking...\n"
	$(CC) $(LDFLAGS) $(OBJS) -Ttext=0x400000 -o bootimg
	@echo "\nCombining filesys_img, bootimg, and mp3.img"
	cp ./bootimg ../Ubuntu-Shared
	cp ./mp3.img ../Ubuntu-Shared
	@echo "\nCleaning up files"
	cp $(SRCDIR)/*.o $(SRCDIR)/$(OBJDIR)
	rm -f $(SRCDIR)/*.o
	@echo "\nNow run the debug.sh script from a linux terminal\n"

dep: Makefile.dep

Makefile.dep: $(SRC)
	$(CC) -MM $(CFLAGS) $(SRC) > $@

.PHONY: clean
clean:
	rm -f *.o Makefile.dep bootimg

ifneq ($(MAKECMDGOALS),dep)
ifneq ($(MAKECMDGOALS),clean)
include Makefile.dep
endif
endif
