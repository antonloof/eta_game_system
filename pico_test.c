#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"
#include "hardware/gpio.h"

#include "tls3001.h"
#include "matrix_with_extra.h"
#include "matrices.h"
#include "tetris.h"
#include "scoreboard.h"

#include "hardware/adc.h"

#define TLS_PIN 22
#define TLS_PIO pio0

#define SCOREBOARD_PIN 2
#define SCOREBOARD_PIO pio1

void init_rng();

int main()
{
    stdio_init_all();
    init_rng();
    set_sys_clock_48mhz();

    init_tls3001(TLS_PIN, TLS_PIO, TOTAL_LED_COUNT);
    init_all_matrices();

    tetris_init();

    //scoreboard_init(SCOREBOARD_PIN, SCOREBOARD_PIO);
    //scoreboard_set_score(1234567, 0);

    while (1)
    {
        tetris_update();
    }
    return 0;
}

void init_rng()
{
    adc_init();
    adc_select_input(4);
    srand(adc_read());
    // run some random numbers to make numbers less corralated to seed
    for (int i = 0; i < 100; i++)
    {
        rand();
    }
}