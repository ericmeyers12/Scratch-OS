#	interrupts.S - Assembly Wrapper for Interrupt Handlers
# 	This piece of code takes care of the interrupt handler
# 	and calls the appropriate function to handle the interrupt
#define ASM 1
#include "x86_desc.h"


#define HANDLER(name,send_to_fn)			\
.GLOBL name									;\
name:										;\
	pushal									;\
	pushfl									;\
	call send_to_fn							;\
	popfl									;\
	popal									;\
	iret									;\

# keyboard_handler: interrupt handler for keyboard interrupts
#HANDLER(keyboard_handler, keyboard_interrupt_handler);
# clock_handler: interrupt handler for rtc interrupts
#HANDLER(rtc_handler, rtc_interrupt_handler);
# pit handler: interrupt handler for pit interrupts
#HANDLER(pit_handler, PIT_interrupt_and_schedule);





