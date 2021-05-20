#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/dma.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"

#include "manchester2.pio.h"

static inline void send_word(PIO pio, uint sm, uint data, uint count)
{
    pio_sm_put_blocking(pio, sm, (count << 27) | (count ? (data << (27 - count)) : data));
}

int main()
{
    uint pin = 1;
    stdio_init_all();
    set_sys_clock_48mhz();

    PIO pio = pio0;

    uint offset = pio_add_program(pio, &manchester2_program);
    uint sm = pio_claim_unused_sm(pio, true);

    pio_gpio_init(pio, pin);
    pio_sm_config conf = manchester2_program_get_default_config(offset);
    sm_config_set_out_pins(&conf, pin, 1);
    pio_sm_set_consecutive_pindirs(pio, sm, pin, 1, true);
    sm_config_set_out_shift(&conf, false, true, 32);

    sm_config_set_clkdiv(&conf, 4); // runs comunication at 1 Mhz (ish)
    sm_config_set_set_pins(&conf, pin, 1);

    pio_sm_init(pio, sm, offset, &conf);
    pio_sm_set_enabled(pio, sm, true);

    // reset
    send_word(pio, sm, 0b1111111111111110100, 19);
    send_word(pio, sm, 30, 0);

    // sync
    send_word(pio, sm, 0b111111111111111, 15);
    send_word(pio, sm, 0b000100000000000, 15);
    send_word(pio, sm, 300, 0);

    //some data
    send_word(pio, sm, 0b1111111111111110010, 19);
    for (uint i = 0; i < 3; i++)
    {
        send_word(pio, sm, 0x2fd, 13);
        send_word(pio, sm, 0x40, 13);
        send_word(pio, sm, 0xdd, 13);
    }
    send_word(pio, sm, 30, 0);
    send_word(pio, sm, 0b1111111111111110010, 19);
    send_word(pio, sm, 30, 0);

    while (1)
    {
    }
    return 0;
}
