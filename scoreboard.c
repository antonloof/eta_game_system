#include "scoreboard.h"

#define DISPLAY_COUNT 7
#define SEGMENT_COUNT 7

typedef struct scoreboard_state
{
    uint32_t buf_1[DISPLAY_COUNT], buf_2[DISPLAY_COUNT];

    uint32_t *reading, *writing;
    uint sm;
    uint dma_c;
    PIO pio;
    uint swap_buffers;
} scoreboard_state;

scoreboard_state ss;

uint8_t dig_to_segments[] = {
    0b1111110, // 0
    0b1010000, // 1
    0b1101101, // 2
    0b1011101, // 3
    0b1010011, // 4
    0b0011111, // 5
    0b0111111, // 6
    0b1011000, // 7
    0b1111111, // 8
    0b1011111, // 9
};

uint8_t dig_i_to_display_i[] = {4, 1, 6, 2, 5, 0, 3};

void scoreboard_init_dma();
void scoreboard_init_dma_buf(uint32_t *buf);
void scoreboard_init_pio(uint pin);
void scoreboard_dma_irq_handler();

void scoreboard_init(uint start_pin, PIO pio)
{
    ss.pio = pio;
    ss.swap_buffers = 0;
    ss.reading = ss.buf_1;
    ss.writing = ss.buf_2;
    scoreboard_init_dma();
    scoreboard_init_dma_buf(ss.reading);
    scoreboard_init_dma_buf(ss.writing);
    scoreboard_init_pio(start_pin);

    scoreboard_dma_irq_handler(); // start it all
}

void scoreboard_set_score(uint score, uint leading_zero)
{
    for (int i = 0; i < DISPLAY_COUNT; i++)
    {
        ss.writing[dig_i_to_display_i[i]] &= 0b11111110000000; // clear segments
        if (score || !i || leading_zero)
        {
            ss.writing[dig_i_to_display_i[i]] |= dig_to_segments[score % 10];
        }
        score /= 10;
    }
    ss.swap_buffers = 1;
}

void scoreboard_init_pio(uint pin)
{
    ss.sm = pio_claim_unused_sm(ss.pio, true);

    uint offset = pio_add_program(ss.pio, &seven_segment_program);

    for (uint i = 0; i < SEGMENT_COUNT + DISPLAY_COUNT; i++)
    {
        pio_gpio_init(ss.pio, pin + i);
    }

    pio_sm_config conf = seven_segment_program_get_default_config(offset);
    pio_sm_set_consecutive_pindirs(ss.pio, ss.sm, pin, SEGMENT_COUNT + DISPLAY_COUNT, true);

    sm_config_set_out_pins(&conf, pin, SEGMENT_COUNT + DISPLAY_COUNT);
    sm_config_set_out_shift(&conf, true, true, 28);
    sm_config_set_clkdiv(&conf, 48); // run it quite slowly

    pio_sm_init(ss.pio, ss.sm, offset, &conf);
    pio_sm_set_enabled(ss.pio, ss.sm, true);
}

void scoreboard_test()
{
    for (uint i = 0; i < DISPLAY_COUNT; i++)
    {
        pio_sm_put_blocking(ss.pio, ss.sm, (1 << (SEGMENT_COUNT + i)) + 0x7F);
    }
}

void scoreboard_dma_irq_handler()
{
    dma_hw->ints1 = 1u << ss.dma_c; // clear interrupt
    if (ss.swap_buffers)
    {
        uint32_t *tmp = ss.reading;
        ss.reading = ss.writing;
        ss.writing = tmp;
        ss.swap_buffers = 0;
    }
    dma_channel_set_read_addr(ss.dma_c, ss.reading, true); // retrigger dma
}

void scoreboard_init_dma_buf(uint32_t *buf)
{
    for (uint i = 0; i < DISPLAY_COUNT; i++)
    {
        buf[i] = 1 << (SEGMENT_COUNT + i);
    }
}

void scoreboard_init_dma()
{
    ss.dma_c = dma_claim_unused_channel(true);
    dma_channel_config conf = dma_channel_get_default_config(ss.dma_c);

    channel_config_set_transfer_data_size(&conf, DMA_SIZE_32);
    channel_config_set_dreq(&conf, DREQ_PIO1_TX0 + ss.sm);
    dma_channel_set_irq1_enabled(ss.dma_c, true);

    irq_set_enabled(DMA_IRQ_1, true);
    irq_set_exclusive_handler(DMA_IRQ_1, scoreboard_dma_irq_handler);
    dma_channel_configure(ss.dma_c, &conf, &pio1_hw->txf[ss.sm], NULL, DISPLAY_COUNT, false);
}
