# boot.S - start point for the kernel after GRUB gives us control

#define ASM     1

#include "multiboot.h"
#include "x86_desc.h"

# Declare a multiboot header that marks the program as a kernel. These are magic
# values that are documented in the multiboot standard. The bootloader will
# search for this signature in the first 8 KiB of the kernel file, aligned at a
# 32-bit boundary. The signature is in its own section so the header can be
# forced to be within the first 8 KiB of the kernel file.
.section .multiboot
.align 4
.long MULTIBOOT_HEADER_MAGIC
.long MULTIBOOT_HEADER_FLAGS
.long -(MULTIBOOT_HEADER_MAGIC+MULTIBOOT_HEADER_FLAGS)


; # Set up stack to be 16kB large and define boundaries.
; .section .bss
; .align 16
; stack_bottom:
; .skip 4194304  # 4MB
; stack_top:

# Linker will jump to this section as its entry (as defined in linker.ld)
.section .text
.global _start
.type _start, @function
_start:
	# The bootloader loads into 32-bit protected mode with
	# interrupts disabled, paging disabled, and the processor state
	# being defaulted to what is in the multiboot standard.

	# Make sure interrupts are off before initializing things
	cli
	jmp continue

continue:
	# Load GDT - Global Descriptor Table - defined in x86_desc.S
	lgdt gdt_desc_ptr

	# Load the IDT
	push %eax
	push %edx
	push %ecx

	call init_interrupts

	pop %ecx
	pop %edx
	pop %eax

	# Load CS with the new descriptor value
	ljmp    $KERNEL_CS, $keep_going

keep_going:
	# Move ESP to top of stack (grows downwards on x86 systems).
	mov $0x800000, %esp

	# Set up the rest of the segment selector registers
	movw    $KERNEL_DS, %cx
	movw    %cx, %ss
	movw    %cx, %ds
	movw    %cx, %es
	movw    %cx, %fs
	movw    %cx, %gs

	# Push the parameters that entry() expects (see kernel.c):
	# eax = multiboot magic
	# ebx = address of multiboot info struct
	pushl   %ebx
	pushl   %eax

	# Enter the main kernel function
	call kernel_main

	#Should not reach here, but if so, spin infinitely
	cli
1:	hlt
	jmp 1b
