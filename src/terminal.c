#include "types.h"
#include "test.h"
#include "x86_desc.h"

static const uint16_t VGA_WIDTH = 80;
static const uint16_t VGA_HEIGHT = 25;

uint16_t terminal_row;
uint16_t terminal_column;
uint16_t terminal_color;
uint16_t* terminal_buffer;

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

uint16_t make_color(enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

uint16_t make_vgaentry(char c, uint8_t color) {
	uint16_t c16 = c;
	uint16_t color16 = color;
	return c16 | color16 << 8;
}



void terminal_initialize() {
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = make_color(COLOR_LIGHT_GREY, COLOR_BLACK);
	terminal_buffer = (uint16_t*) 0xB8000;
	for (uint16_t y = 0; y < VGA_HEIGHT; y++) {
		for (uint16_t x = 0; x < VGA_WIDTH; x++) {
			const uint16_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = make_vgaentry(' ', terminal_color);
		}
	}
}

void terminal_setcolor(uint16_t color) {
	terminal_color = color;
}

void terminal_putentryat(char c, uint8_t color, uint16_t x, uint16_t y) {
	const uint16_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = make_vgaentry(c, color);
}

void terminal_putchar(char c) {
	terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0;
		if (++terminal_row == VGA_HEIGHT) {
			terminal_row = 0;
		}
	}
}

void terminal_writestring(const char* data) {
	uint16_t datalen = strlen(data);
	for (uint16_t i = 0; i < datalen; i++)
		terminal_putchar(data[i]);
}
