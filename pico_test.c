#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/dma.h"
#include "hardware/pio.h"

#include "hello.pio.h"

int main()
{
    uint pin = PICO_DEFAULT_LED_PIN;
    stdio_init_all();

    PIO pio = pio0;

    uint offset = pio_add_program(pio, &hello_program);
    uint sm = pio_claim_unused_sm(pio, true);

    pio_gpio_init(pio, pin);
    pio_sm_config conf = hello_program_get_default_config(offset);
    sm_config_set_out_pins(&conf, pin, 1);
    pio_sm_set_consecutive_pindirs(pio, sm, pin, 1, true);

    pio_sm_init(pio, sm, offset, &conf);
    pio_sm_set_enabled(pio, sm, true);

    while (true)
    {
        pio_sm_put_blocking(pio, sm, 1);
        sleep_ms(500);

        pio_sm_put_blocking(pio, sm, 0);
        sleep_ms(500);
    }
    return 0;
}
