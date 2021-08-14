#include "pico/stdlib.h"
#include "hardware/pio.h"
#include "hardware/dma.h"
#include "hardware/irq.h"
#include "manchester.pio.h"

typedef struct tls3001_pixel
{
    uint rg;
    uint b;
} tls3001_pixel;

void init_tls3001(uint pin, PIO pio, uint _pixel_count);
void set_rgb(uint pix, uint r, uint g, uint b);
void swap_buffers();

uint get_word(uint data, uint count);
uint init_pio(PIO pio, uint pin);
void init_dma();
void dma_irq0_handler();
void init_dma_buf();
void init_double_buffers();
