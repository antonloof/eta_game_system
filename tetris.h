#pragma once

#include "pico/stdlib.h"
#include "matrices.h"
#include "scoreboard.h"
#include <stdlib.h>

#define TETRIMINO_SIZE 4
#define TETRIMINO_COUNT 7
#define TETRIMINO_ROTATIONS 4

typedef struct tetris_point
{
    uint has_block;
    uint r, g, b;
} tetris_point;

typedef struct piece
{
    int x, y;
    uint i;
    uint rot;
    uint r, g, b;
    uint collided;
} piece;

void tetris_init();
uint tetris_update();
void tetris_move_x(int dx);
void tetris_rotate_piece();
void tetris_button_action(uint8_t state);
void tetris_swap_hold();
void tetris_drop_piece();
