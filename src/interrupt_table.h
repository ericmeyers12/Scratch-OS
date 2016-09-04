#ifndef _INTERRUPT_TABLE_H
#define _INTERRUPT_TABLE_H

/**
 * Function to set up interrupts for the system.
  * Only needs to be called once upon boot.
  */
int init_interrupts(void);

/*Setup of IDT*/
void setup_idt(void);

/*Setup of all Exception Handlers*/
void setup_exception_handlers (void);

#endif
