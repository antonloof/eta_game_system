#include "controller.h"

void controller_uart0_irq();
void controller_uart1_irq();
void controller_uart_irq(controller *ctl);

void controller_callback_nop(uint8_t d);

controller player0 = {controller_callback_nop, 0, 1, 0, uart0, UART0_IRQ, controller_uart0_irq};
controller player1 = {controller_callback_nop, 1, 17, 16, uart1, UART1_IRQ, controller_uart1_irq};

void controller_init(controller_callback callback, controller *out)
{
    uart_init(out->uart, 115200);
    uart_set_hw_flow(out->uart, false, false);
    uart_set_format(out->uart, 8, 1, UART_PARITY_NONE);
    uart_set_translate_crlf(out->uart, false);
    uart_set_fifo_enabled(out->uart, false);

    out->callback = callback;

    gpio_set_function(out->rxpin, GPIO_FUNC_UART);
    gpio_set_function(out->txpin, GPIO_FUNC_UART);
    // rx interrupts

    irq_set_exclusive_handler(out->irq_flag, out->irq_happened);
    irq_set_enabled(out->irq_flag, true);
    uart_set_irq_enables(out->uart, true, false);
}

void controller_callback_nop(uint8_t d) {}

void controller_send(controller *ctl, uint8_t data)
{
    uart_putc_raw(ctl->uart, data);
}

void controller_uart0_irq()
{
    controller_uart_irq(&player0);
}

void controller_uart1_irq()
{
    controller_uart_irq(&player1);
}

void controller_uart_irq(controller *ctl)
{
    while (uart_is_readable(ctl->uart))
    {
        uint8_t ch = uart_getc(ctl->uart);
        ctl->callback(ch);
    }
}