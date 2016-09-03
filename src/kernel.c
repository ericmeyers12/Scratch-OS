#include "terminal.h"

void kernel_main() {
	/* Initialize terminal interface */
	terminal_initialize();

	/* Since there is no support for newlines in terminal_putchar
         * yet, '\n' will produce some VGA specific character instead.
         * This is normal.
         */
	volatile int test_int = test(1);

	terminal_writestring("test1234");

	terminal_writestring("Hello this is a test.");

}
