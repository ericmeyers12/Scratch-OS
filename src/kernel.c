#include "terminal.h"
#include "lib.h"

void kernel_main() {
	/* Initialize terminal interface */
	terminal_initialize();

	/* Test Function */
	volatile int test_int = test(1);
	
	/* Testing printf*/
	volatile int test = printf("this is a test:%d\nhello\nERIC'S O.S.", 1);

}
