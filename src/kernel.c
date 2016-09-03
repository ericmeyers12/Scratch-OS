#include "terminal.h"
#include "lib.h"

void kernel_main() {
	/* Initialize terminal interface */
	terminal_initialize();

	/* Test Function */
	volatile int test_int = test(1);
	
	/* Testing printf*/
	volatile int test = printf("%d\n", 1);

	/* No newline support yet*/
	terminal_writestring("Hello this is a test.");

}
