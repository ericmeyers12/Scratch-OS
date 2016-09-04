#include "terminal.h"
#include "i8259.h"
#include "lib.h"
#include "rtc.h"
#include "keyboard.h"

void kernel_main() {
	/* Initialize PIC*/
	i8259_init();

	/* Allow for interrupts now*/
	sti();

	/*Initialize Real Time Clock*/
	init_rtc();

	/* Initialize Keyboard*/
	init_keyboard();

	/* Test Function */
	(void)test(1);
	
	/* Testing printf*/
	(void)printf("this is a test:%d\nhello\nERIC'S O.S.", 1);

	/* Spin (nicely, so we don't chew up cycles) */
		asm volatile(".1: hlt; jmp .1;");

}
