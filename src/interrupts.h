/*
 * interrupts.h
 *
 *  Created on: Sep 3, 2016
 *      Author: Eric_Meyers
 */

#ifndef _INTERRUPTS_H_
#define _INTERRUPTS_H_


/* Clock interrupt asm wrapper */
extern void rtc_handler();

/* Keyboard interrupt asm wrapper */
extern void keyboard_handler();



#endif /* SRC_INTERRUPTS_H_ */
