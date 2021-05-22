#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/dma.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"

#include "manchester.pio.h"

#define DATA_BITS_PER_WORD 27
#define COLOR_PULSE_LEN 13

#define SYNC_PULSE_1 0b111111111111111
#define SYNC_PULSE_1_LEN 15
#define SYNC_PULSE_2 0b000100000000000
#define SYNC_PULSE_2_LEN 15

#define RST_PULSE 0b1111111111111110100
#define RST_PULSE_LEN 19

#define DATA_HEADER_PULSE 0b1111111111111110010
#define DATA_HEADER_PULSE_LEN 19

typedef struct tls3001_pixel
{
    uint rg;
    uint b;
} tls3001_pixel;

static inline void set_rgb(tls3001_pixel *pix, uint r, uint g, uint b)
{
    pix->b = COLOR_PULSE_LEN << DATA_BITS_PER_WORD | ((b & 0xFFF) << (DATA_BITS_PER_WORD - COLOR_PULSE_LEN));
    pix->rg = (2 * COLOR_PULSE_LEN) << DATA_BITS_PER_WORD | ((r & 0xFFF) << (DATA_BITS_PER_WORD - COLOR_PULSE_LEN)) | ((g & 0xFFF) << (DATA_BITS_PER_WORD - 2 * COLOR_PULSE_LEN));
}

static inline void send_word(PIO pio, uint sm, uint data, uint count)
{
    pio_sm_put_blocking(pio, sm, (count << DATA_BITS_PER_WORD) | (count ? (data << (DATA_BITS_PER_WORD - count)) : data));
}

tls3001_pixel dma_buf[256];

uint init_pio(PIO pio, uint pin);
void init_dma();

int main()
{
    stdio_init_all();
    set_sys_clock_48mhz();

    uint pin = 1;
    PIO pio = pio0;
    uint sm = init_pio(pio, pin);
    // reset
    send_word(pio, sm, RST_PULSE, RST_PULSE_LEN);
    send_word(pio, sm, 30, 0);

    // sync
    send_word(pio, sm, SYNC_PULSE_1, SYNC_PULSE_1_LEN);
    send_word(pio, sm, SYNC_PULSE_2, SYNC_PULSE_2_LEN);
    send_word(pio, sm, 300, 0);

    //some data
    send_word(pio, sm, DATA_HEADER_PULSE, DATA_HEADER_PULSE_LEN);
    for (uint i = 0; i < 3; i++)
    {
        send_word(pio, sm, 0x2fd, COLOR_PULSE_LEN);
        send_word(pio, sm, 0x40, COLOR_PULSE_LEN);
        send_word(pio, sm, 0xdd, COLOR_PULSE_LEN);
    }
    send_word(pio, sm, 30, 0);
    send_word(pio, sm, DATA_HEADER_PULSE, DATA_HEADER_PULSE_LEN);
    send_word(pio, sm, 30, 0);

    while (1)
    {
    }
    return 0;
}

void init_dma(uint sm)
{
    uint dma_c = dma_claim_unused_channel(true);
    dma_channel_config conf = dma_channel_get_default_config(dma_c);

    channel_config_set_read_increment(&conf, true);
    channel_config_set_write_increment(&conf, false);
    channel_config_set_transfer_data_size(&conf, DMA_SIZE_32); // CH0 part does not matter this is 0x2 :D
    channel_config_set_dreq(&conf, DREQ_PIO0_TX0 + sm);
}

uint init_pio(PIO pio, uint pin)
{
    uint sm = pio_claim_unused_sm(pio, true);

    uint offset = pio_add_program(pio, &manchester_program);
    pio_gpio_init(pio, pin);
    pio_sm_config conf = manchester_program_get_default_config(offset);
    sm_config_set_out_pins(&conf, pin, 1);
    pio_sm_set_consecutive_pindirs(pio, sm, pin, 1, true);
    sm_config_set_out_shift(&conf, false, true, 32);

    sm_config_set_clkdiv(&conf, 4); // runs comunication at 1 Mhz (ish)
    sm_config_set_set_pins(&conf, pin, 1);

    pio_sm_init(pio, sm, offset, &conf);
    pio_sm_set_enabled(pio, sm, true);
    return sm;
}