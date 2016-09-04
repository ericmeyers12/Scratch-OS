/*
 * terminal.h
 *
 *  Created on: Sep 2, 2016
 *      Author: Eric_Meyers
 */

#ifndef TERMINAL_H_
#define TERMINAL_H_

#include "types.h"
#include "test.h"
#include "lib.h"
#include "x86_desc.h"

/* Hardware text mode color constants. */
enum vga_color {
	COLOR_BLACK = 0,
	COLOR_BLUE = 1,
	COLOR_GREEN = 2,
	COLOR_CYAN = 3,
	COLOR_RED = 4,
	COLOR_MAGENTA = 5,
	COLOR_BROWN = 6,
	COLOR_LIGHT_GREY = 7,
	COLOR_DARK_GREY = 8,
	COLOR_LIGHT_BLUE = 9,
	COLOR_LIGHT_GREEN = 10,
	COLOR_LIGHT_CYAN = 11,
	COLOR_LIGHT_RED = 12,
	COLOR_LIGHT_MAGENTA = 13,
	COLOR_LIGHT_BROWN = 14,
	COLOR_WHITE = 15,
};


uint16_t make_color(enum vga_color fg, enum vga_color bg);

uint16_t make_vgaentry(char c, uint8_t color);

void terminal_initialize();

void terminal_setcolor(uint16_t color);



#endif /* TERMINAL_H_ */
