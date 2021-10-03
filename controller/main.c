#include "stm8l101f3.h" 

#define DEBUONCE_THRESH 100

unsigned char received, last_received;

int count = 0;
int has_send = 1;
int a = 0;

main()
{
	sfr_CLK.CKDIVR.byte = 0; // FULL SPEED
	sfr_CLK.PCKENR.byte = 0xFF; // enable all (usart)

	// PC0 and PC1 push pull for leds (does not work, are OD only)
	// PC4 should output a "high" all the time
	// PC3 is tx and should be output, push pull, high speed
	// PC2 is rx and should be input no interrupt
	sfr_PORTC.DDR.byte = 0b00011011;
	sfr_PORTC.CR1.C10 = 1; // push pull
	sfr_PORTC.CR1.C11 = 1; // push pull
	sfr_PORTC.CR1.C13 = 1; // push pull
	sfr_PORTC.CR1.C14 = 1; // push pull
	sfr_PORTC.CR2.C23 = 1; // high speed
	
	// port b is all inputs with pullups. 
	sfr_PORTB.DDR.byte = 0;
	sfr_PORTB.CR1.byte = 0xFF;
	sfr_PORTB.CR2.byte = 0;
	
	
	// configure usart
	sfr_USART.CR1.USARTD = 0; // dont disable
	sfr_USART.CR1.MSL = 0; // 8 bit bytes
	sfr_USART.CR3.STOP = 0; // 1 stop bit

	// baudrate 16Mhz/115200 baud ~= 139 = 0x008B
	// bbr2 should be written to first, update on brr1 write
	sfr_USART.BRR2.byte = 0x0B;
	sfr_USART.BRR1.byte = 0x08;
	
	
	sfr_USART.CR2.REN = 1; // enable rx
	sfr_USART.CR2.TEN = 1; // enable transmitter
	
	// the controller is connected
	sfr_PORTC.ODR.ODR4 = 1;
		
	while (1) {
		received = sfr_PORTB.IDR.byte;
		if (received != last_received) {
			a++;
		}
		
		if (!has_send) {
			if (received == last_received) {
				count++;
				if (count == DEBUONCE_THRESH) {
					count = 0;
					has_send = 1;
					while (!sfr_USART.SR.TXE);
					sfr_USART.DR.byte = received;
				}
			} else {
				count = 0;
			}
		} else {
			if (received != last_received) {
				has_send = 0;
			}
		}
		last_received = received;
	}
}
