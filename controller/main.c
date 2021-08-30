#include "stm8l101f3.h" 

void portBInterrupt(void);

int state = 0;

main()
{
	sfr_CLK.CKDIVR.byte = 0; // FULL SPEED
	sfr_CLK.PCKENR.byte = 0xFF; // enable all (usart)

	// PC0 and PC1 open drain for leds
	// PC4 should output a "high" all the time
	// PC3 is tx and should be output, push pull, high speed
	sfr_PORTC.DDR.byte = 0b00011011;
	sfr_PORTC.CR1.C14 = 1;
	sfr_PORTC.CR1.C13 = 1;
	sfr_PORTC.CR2.C23 = 1;
	
	// port b is all inputs all interrupts
	sfr_PORTB.DDR.byte = 0;
	sfr_PORTB.CR1.byte = 0;
	sfr_PORTB.CR2.byte = 0xFF;
	
	// interrupt on all edges pins B0-B7 calls EXTIB
	sfr_ITC_EXTI.CR3.PBIS = 0b11;
	sfr_ITC_EXTI.CONF.PBHIS = 1;
	sfr_ITC_EXTI.CONF.PBLIS = 1;
	
	// configure usart
	sfr_USART.CR1.USARTD = 0; // dont disable
	sfr_USART.CR1.MSL = 0; // 8 bit bytes
	sfr_USART.CR3.STOP = 0; // 1 stop bit

	// baudrate 16Mhz/115200 baud ~= 139 = 0x008B
	// bbr2 should be written to first, update on brr1 write
	sfr_USART.BRR2.byte = 0x0B;
	sfr_USART.BRR1.byte = 0x08;
	
	sfr_USART.CR2.TEN = 1; // enable transmitter
	sfr_USART.DR.byte = 0b10101010; // send something
	
	// the controller is connected
	sfr_PORTC.ODR.ODR4 = 1;
	
	ENABLE_INTERRUPTS();

	
	while (1);
}

@interrupt void portBInterrupt(void) {
	sfr_ITC_EXTI.SR2.PBF = 1; // clear interrupt
	sfr_PORTC.ODR.ODR0 = state;
	state = !state;
}