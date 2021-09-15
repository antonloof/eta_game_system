#include "tls3001.h"

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
#define PIXEL_OFFSET 3
#define RESET_PULSE_LEN 2
#define LED_MAX 0x3FF

#define MAX_DMA_COUNT 1000

tls3001_pixel dma_buf_1[MAX_DMA_COUNT], dma_buf_2[MAX_DMA_COUNT];
tls3001_pixel *reading, *writing;
volatile uint should_swap_buffers;
uint dma_c;
uint sm;
uint pixel_count;

uint get_word(uint data, uint count);
uint init_pio(PIO pio, uint pin);
void tls3001_init_dma();
void tls3001_dma_irq0_handler();
void tls3001_init_dma_buf();
void init_double_buffers();

void init_tls3001(uint pin, PIO pio, uint _pixel_count)
{
    pixel_count = _pixel_count;
    reading = dma_buf_1;
    writing = dma_buf_2;
    should_swap_buffers = 0;

    tls3001_init_dma();
    tls3001_init_dma_buf(dma_buf_1);
    tls3001_init_dma_buf(dma_buf_2);

    sm = init_pio(pio, pin);
    tls3001_dma_irq0_handler(); // kick it off, legooo
    init_double_buffers();
}

void set_rgb(uint pix, uint r, uint g, uint b)
{
    writing[PIXEL_OFFSET + pix].b = COLOR_PULSE_LEN << DATA_BITS_PER_WORD | ((b & LED_MAX) << (DATA_BITS_PER_WORD - COLOR_PULSE_LEN));
    writing[PIXEL_OFFSET + pix].rg = (2 * COLOR_PULSE_LEN) << DATA_BITS_PER_WORD | ((r & LED_MAX) << (DATA_BITS_PER_WORD - COLOR_PULSE_LEN)) | ((g & LED_MAX) << (DATA_BITS_PER_WORD - 2 * COLOR_PULSE_LEN));
}

void swap_buffers()
{
    should_swap_buffers = 1;
}

uint get_word(uint data, uint count)
{
    return (count << DATA_BITS_PER_WORD) | (data << (DATA_BITS_PER_WORD - count));
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

void tls3001_dma_irq0_handler()
{
    dma_hw->ints0 = 1u << dma_c; // clear interrupt
    if (should_swap_buffers)
    {
        tls3001_pixel *tmp;
        tmp = reading;
        reading = writing;
        writing = tmp;
        should_swap_buffers = 0;
    }
    dma_channel_set_read_addr(dma_c, reading, true); // retrigger dma
}

void tls3001_init_dma_buf(tls3001_pixel *target)
{
    target[0].rg = get_word(RST_PULSE, RST_PULSE_LEN);
    target[0].b = 30;

    target[1].rg = get_word(SYNC_PULSE_1, SYNC_PULSE_1_LEN);
    target[1].b = get_word(SYNC_PULSE_2, SYNC_PULSE_2_LEN);

    target[2].rg = 100 * pixel_count;
    target[2].b = get_word(DATA_HEADER_PULSE, DATA_HEADER_PULSE_LEN);

    target[PIXEL_OFFSET + pixel_count].rg = 30;
    target[PIXEL_OFFSET + pixel_count].b = get_word(DATA_HEADER_PULSE, DATA_HEADER_PULSE_LEN);

    target[pixel_count + 1].rg = 0;
    target[pixel_count + 1].b = 0;
}

void tls3001_init_dma()
{
    dma_c = dma_claim_unused_channel(true);
    dma_channel_config conf = dma_channel_get_default_config(dma_c);

    channel_config_set_read_increment(&conf, true);
    channel_config_set_write_increment(&conf, false);
    channel_config_set_transfer_data_size(&conf, DMA_SIZE_32);
    channel_config_set_dreq(&conf, DREQ_PIO0_TX0 + sm);
    dma_channel_set_irq0_enabled(dma_c, true);
    irq_set_enabled(DMA_IRQ_0, true);
    irq_add_shared_handler(DMA_IRQ_0, tls3001_dma_irq0_handler, PICO_SHARED_IRQ_HANDLER_DEFAULT_ORDER_PRIORITY);
    dma_channel_configure(dma_c, &conf, &pio0_hw->txf[sm], NULL, 2 * (pixel_count + PIXEL_OFFSET + RESET_PULSE_LEN), false);
}

void init_double_buffers()
{
    for (uint i = 0; i < pixel_count; i++)
    {
        set_rgb(i, 0, 0, 0);
    }
    should_swap_buffers = 1;
    while (should_swap_buffers)
    {
    }
    for (uint i = 0; i < pixel_count; i++)
    {
        set_rgb(i, 0, 0, 0);
    }
}
