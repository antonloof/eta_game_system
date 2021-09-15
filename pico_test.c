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

#define TLS_PIN 22
#define TLS_PIO pio0

#define SCOREBOARD_PIN 2
#define SCOREBOARD_PIO pio1

uint left_pin = 10;
uint right_pin = 11;
uint down_pin = 12;
uint rotate_pin = 13;

int main()
{
    stdio_init_all();
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
