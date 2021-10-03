#pragma once

#include "pico/stdlib.h"
#include "hardware/uart.h"
#include "hardware/irq.h"

typedef void (*controller_callback)(uint8_t);

typedef struct controller
{
    controller_callback callback;
    uint player_id;
    uint rxpin, txpin;
    uart_inst_t *uart;
    int irq_flag;
    void (*irq_happened)(void);
} controller;

extern controller player0, player1;

void controller_init(controller_callback callback, controller *out);
void controller_send(controller *ctl, uint8_t data);