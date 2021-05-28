#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/dma.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"
#include "hardware/irq.h"

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

#define PIXEL_COUNT 255
#define DMA_COUNT (PIXEL_COUNT + 5)
#define PIXEL_OFFSET 3

#define LED_MAX 0x3FF

typedef struct tls3001_pixel
{
    uint rg;
    uint b;
} tls3001_pixel;

tls3001_pixel dma_buf[DMA_COUNT];
uint dma_c;
uint sm;

static inline void set_rgb(uint pix, uint r, uint g, uint b);
static inline uint get_word(uint data, uint count);
uint init_pio(PIO pio, uint pin);
void init_dma();
void dma_irq0_handler();
void init_dma_buf();

int main()
{
    stdio_init_all();
    set_sys_clock_48mhz();

    uint pin = 1;
    PIO pio = pio0;
    sm = init_pio(pio, pin);
    init_dma();
    init_dma_buf();
    dma_irq0_handler(); // kick it off, legooo
    uint col = 0;
    while (1)
    {
        sleep_ms(10);
        col++;
        for (uint i = 0; i < PIXEL_COUNT; i++)
        {
            set_rgb(i, col, 0, col);
        }
    }
    return 0;
}

void dma_irq0_handler()
{
    dma_hw->ints0 = 1u << dma_c;                     // clear interrupt
    dma_channel_set_read_addr(dma_c, dma_buf, true); // retrigger dma
}

void init_dma_buf()
{
    dma_buf[0].rg = get_word(RST_PULSE, RST_PULSE_LEN);
    dma_buf[0].b = 30;

    dma_buf[1].rg = get_word(SYNC_PULSE_1, SYNC_PULSE_1_LEN);
    dma_buf[1].b = get_word(SYNC_PULSE_2, SYNC_PULSE_2_LEN);

    dma_buf[2].rg = 100 * PIXEL_COUNT;
    dma_buf[2].b = get_word(DATA_HEADER_PULSE, DATA_HEADER_PULSE_LEN);

    dma_buf[DMA_COUNT - 2].rg = 30;
    dma_buf[DMA_COUNT - 2].b = get_word(DATA_HEADER_PULSE, DATA_HEADER_PULSE_LEN);

    dma_buf[DMA_COUNT - 1].rg = 0;
    dma_buf[DMA_COUNT - 1].b = 0;
}

void init_dma()
{
    dma_c = dma_claim_unused_channel(true);
    dma_channel_config conf = dma_channel_get_default_config(dma_c);

    channel_config_set_read_increment(&conf, true);
    channel_config_set_write_increment(&conf, false);
    channel_config_set_transfer_data_size(&conf, DMA_SIZE_32);
    channel_config_set_dreq(&conf, DREQ_PIO0_TX0 + sm);
    dma_channel_set_irq0_enabled(dma_c, true);
    irq_set_enabled(DMA_IRQ_0, true);
    irq_set_exclusive_handler(DMA_IRQ_0, dma_irq0_handler);
    dma_channel_configure(dma_c, &conf, &pio0_hw->txf[sm], NULL, 2 * DMA_COUNT, false);
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

    sm_config_set_clkdiv(&conf, 3); // runs comunication at 1 Mhz (ish)
    sm_config_set_set_pins(&conf, pin, 1);

    pio_sm_init(pio, sm, offset, &conf);
    pio_sm_set_enabled(pio, sm, true);
    return sm;
}

static inline void set_rgb(uint pix, uint r, uint g, uint b)
{
    dma_buf[PIXEL_OFFSET + pix].b = COLOR_PULSE_LEN << DATA_BITS_PER_WORD | ((b & LED_MAX) << (DATA_BITS_PER_WORD - COLOR_PULSE_LEN));
    dma_buf[PIXEL_OFFSET + pix].rg = (2 * COLOR_PULSE_LEN) << DATA_BITS_PER_WORD | ((r & LED_MAX) << (DATA_BITS_PER_WORD - COLOR_PULSE_LEN)) | ((g & LED_MAX) << (DATA_BITS_PER_WORD - 2 * COLOR_PULSE_LEN));
}

static inline uint get_word(uint data, uint count)
{
    return (count << DATA_BITS_PER_WORD) | (data << (DATA_BITS_PER_WORD - count));
}
