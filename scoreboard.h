#pragma once

#include "pico/stdlib.h"
#include "hardware/dma.h"
#include "hardware/irq.h"
#include "hardware/pio.h"
#include "seven_segment.pio.h"

void scoreboard_init(uint start_pin, PIO pio);
void scoreboard_set_score(uint score, uint leading_zero);
void scoreboard_test();