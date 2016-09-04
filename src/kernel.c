#include "terminal.h"
#include "lib.h"
#include "rtc.h"

void kernel_main() {
	i8259_init();
	sti();
	init_rtc();

	/* Test Function */
	volatile int test_int = test(1);
	
	/* Testing printf*/
	volatile int test = printf("this is a test:%d\nhello\nERIC'S O.S.", 1);

	test = 1/0;
	/* Spin (nicely, so we don't chew up cycles) */
		asm volatile(".1: hlt; jmp .1;");

}
