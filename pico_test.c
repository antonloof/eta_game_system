#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/dma.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"
#include "hardware/irq.h"

#include "tls3001.h"

#define TLS_PIN 1
#define TLS_PIO pio0

#define WIDTH 10
#define HEIGHT 24

#define SECONDARY_SCREEN_SIZE 16
#define SECONDARY_SCREEN_COUNT 2
#define SECONDARY_SCREEN_EXTRA_LIGHTS 7

#define SIDE_LIGHT_COUNT 15
#define PIXEL_COUNT (WIDTH * HEIGHT + SIDE_LIGHT_COUNT)
#define TLS3001_COUNT (PIXEL_COUNT + SECONDARY_SCREEN_SIZE * SECONDARY_SCREEN_COUNT + SECONDARY_SCREEN_EXTRA_LIGHTS)

#define TETRIMINO_SIZE 4

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

piece active_piece;

tetris_point board[WIDTH * HEIGHT];
uint tetriminos[7][4][TETRIMINO_SIZE * TETRIMINO_SIZE] = {
    {
        {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 0,
         1, 1, 1, 0,
         1, 0, 0, 0,
         0, 0, 0, 0},
        {1, 1, 0, 0,
         0, 1, 0, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},
        {0, 0, 1, 0,
         1, 1, 1, 0,
         0, 0, 0, 0,
         0, 0, 0, 0},
        {0, 1, 0, 0,
         0, 1, 0, 0,
         0, 1, 1, 0,
         0, 0, 0, 0},
    },
    {
        {0, 0, 0, 0,
         1, 1, 1, 0,
         0, 0, 1, 0,
         0, 0, 0, 0},
        {0, 1, 0, 0,
         0, 1, 0, 0,
         1, 1, 0, 0,
         0, 0, 0, 0},
        {1, 0, 0, 0,
         1, 1, 1, 0,
         0, 0, 0, 0,
         0, 0, 0, 0},
        {0, 1, 1, 0,
         0, 1, 0, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},
    },
    {
        {0, 1, 1, 0,
         1, 1, 0, 0,
         0, 0, 0, 0,
         0, 0, 0, 0},
        {0, 1, 0, 0,
         0, 1, 1, 0,
         0, 0, 1, 0,
         0, 0, 0, 0},
        {0, 0, 0, 0,
         0, 1, 1, 0,
         1, 1, 0, 0,
         0, 0, 0, 0},
        {1, 0, 0, 0,
         1, 1, 0, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},

    },
    {
        {0, 0, 0, 0,
         1, 1, 0, 0,
         0, 1, 1, 0,
         0, 0, 0, 0},
        {0, 1, 0, 0,
         1, 1, 0, 0,
         1, 0, 0, 0,
         0, 0, 0, 0},
        {1, 1, 0, 0,
         0, 1, 1, 0,
         0, 0, 0, 0,
         0, 0, 0, 0},
        {0, 0, 1, 0,
         0, 1, 1, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},
    },
    {
        {0, 1, 0, 0,
         1, 1, 1, 0,
         0, 0, 0, 0,
         0, 0, 0, 0},
        {0, 1, 0, 0,
         0, 1, 1, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},
        {0, 0, 0, 0,
         1, 1, 1, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},
        {0, 1, 0, 0,
         1, 1, 0, 0,
         0, 1, 0, 0,
         0, 0, 0, 0},
    },
};

typedef struct trigger_pin
{
    uint gpio;
    uint pressed;
    uint64_t debounce_us;
    uint64_t last_press_time;
} trigger_pin;

const uint SIDE_LIGHTS[SIDE_LIGHT_COUNT] = {10, 21, 32, 43, 54, 75, 86, 97, 108, 119, 130, 141, 152, 173, 194};
uint BOARD_TO_PIXEL[WIDTH * HEIGHT];

void update_board();
void draw_board();
void init_board();
void init_buttons();
void rotate_piece();
void move_x(int dx);
void clear_piece();
void piece_to_board();
uint check_pos_ok();
void place_tetrimino(uint i, uint x, uint rot, uint r, uint g, uint b, piece *out);
uint check_scoring();

uint pin_pressed(trigger_pin *pin);

uint left_pin = 10;
uint right_pin = 11;
uint down_pin = 12;
uint rotate_pin = 13;

uint speed = 500000;
uint speed_up_factor = 0;

uint score = 0;

int main()
{
    trigger_pin left_p = {left_pin, 0, 200000, 0};
    trigger_pin right_p = {right_pin, 0, 200000, 0};
    trigger_pin rotate_p = {rotate_pin, 0, 200000, 0};

    stdio_init_all();
    set_sys_clock_48mhz();

    init_tls3001(TLS_PIN, TLS_PIO, TLS3001_COUNT);
    init_board();
    init_buttons();
    uint64_t time;
    uint64_t last_frame = 0;
    place_tetrimino(0, 4, 0, 0xFF, 0, 0, &active_piece);
    uint button_action = 0;

    // test aux displays
    for (int j = 0; j < SECONDARY_SCREEN_SIZE * SECONDARY_SCREEN_COUNT + SECONDARY_SCREEN_EXTRA_LIGHTS; j++)
    {
        set_rgb(PIXEL_COUNT + j, 0, 0xff, 0xff);
    }

    uint i = 0;
    while (1)
    {
        if (pin_pressed(&left_p))
        {
            move_x(1);
            button_action = 1;
        }
        if (pin_pressed(&right_p))
        {
            move_x(-1);
            button_action = 1;
        }
        if (pin_pressed(&rotate_p))
        {
            rotate_piece();
            button_action = 1;
        }

        if (gpio_get(down_pin))
        {
            speed_up_factor = 0;
        }
        else
        {
            speed_up_factor = 2;
        }

        time = to_us_since_boot(get_absolute_time());
        if (time - last_frame > (speed >> speed_up_factor))
        {
            last_frame = time;
            update_board();
            draw_board();
            if (active_piece.collided)
            {
                uint got_rows = check_scoring();
                if (got_rows == 1)
                {
                    score += 4;
                }
                else if (got_rows == 2)
                {
                    score += 10;
                }
                else if (got_rows == 3)
                {
                    score += 30;
                }
                else if (got_rows == 4)
                {
                    score += 120;
                }
                place_tetrimino(i, 4, 0, 0xFF, 0, 0, &active_piece);
            }
        }
        if (button_action)
        {
            button_action = 0;
            draw_board();
        }
    }
    return 0;
}

uint pin_pressed(trigger_pin *pin)
{
    uint64_t time = to_us_since_boot(get_absolute_time());
    if (time > pin->last_press_time + pin->debounce_us)
    {
        if (gpio_get(pin->gpio))
        {
            pin->pressed = 0;
        }
        else if (!pin->pressed)
        {
            pin->last_press_time = time;
            pin->pressed = 1;
            return 1;
        }
    }
    return 0;
}

uint check_scoring()
{
    uint scored_rows = 0;
    for (uint y = 0; y < HEIGHT; y++)
    {
        uint all_up = 1;
        for (uint x = 0; x < WIDTH; x++)
        {
            if (!board[x * HEIGHT + y].has_block)
            {
                all_up = 0;
            }
        }
        if (all_up)
        {
            scored_rows++;
            for (uint x = 0; x < WIDTH; x++)
            {
                tetris_point *point = &board[x * HEIGHT + y];
                point->has_block = 0;
                point->r = 0;
                point->g = 0;
                point->b = 0;
            }
            for (int yy = y - 1; yy >= 0; yy--)
            {
                for (int x = 0; x < WIDTH; x++)
                {
                    tetris_point *source_point = &board[x * HEIGHT + yy];
                    tetris_point *target_point = &board[x * HEIGHT + yy + 1];
                    target_point->has_block = source_point->has_block;
                    target_point->r = source_point->r;
                    target_point->g = source_point->g;
                    target_point->b = source_point->b;
                }
            }
        }
    }
    return scored_rows;
}

void place_tetrimino(uint i, uint x, uint rot, uint r, uint g, uint b, piece *out)
{
    out->i = i;
    out->x = x;
    out->y = 0;
    out->r = r;
    out->g = g;
    out->b = b;
    out->collided = 0;
    out->rot = rot;
    for (uint xx = 0; xx < TETRIMINO_SIZE; xx++)
    {
        for (uint yy = 0; yy < TETRIMINO_SIZE; yy++)
        {
            if (tetriminos[i][rot][xx + yy * TETRIMINO_SIZE])
            {
                board[(x + xx) * HEIGHT + yy].has_block = 1;
                board[(x + xx) * HEIGHT + yy].r = r;
                board[(x + xx) * HEIGHT + yy].g = g;
                board[(x + xx) * HEIGHT + yy].b = b;
            }
        }
    }
}

void rotate_piece()
{
    clear_piece();
    uint old_rot = active_piece.rot;
    active_piece.rot++;
    if (active_piece.rot == 4)
        active_piece.rot = 0;
    if (!check_pos_ok())
    {
        active_piece.rot = old_rot;
    }
    piece_to_board();
}

uint check_pos_ok()
{
    for (int x = 0; x < TETRIMINO_SIZE; x++)
    {
        for (int y = 0; y < TETRIMINO_SIZE; y++)
        {
            if (tetriminos[active_piece.i][active_piece.rot][x + y * TETRIMINO_SIZE])
            {
                int board_x = active_piece.x + x;
                int board_y = active_piece.y + y;
                if (board_x < 0 || board_x >= WIDTH)
                {
                    return 0;
                }
                if (board_y < 0 || board_y >= HEIGHT)
                {
                    return 0;
                }
                if (board[board_x * HEIGHT + board_y].has_block)
                {
                    return 0;
                }
            }
        }
    }
    return 1;
}

void move_x(int dx)
{
    clear_piece();
    active_piece.x += dx;
    if (!check_pos_ok())
    {
        active_piece.x -= dx;
    }
    piece_to_board();
}

void clear_piece()
{
    for (int x = 0; x < TETRIMINO_SIZE; x++)
    {
        for (int y = 0; y < TETRIMINO_SIZE; y++)
        {
            if (tetriminos[active_piece.i][active_piece.rot][x + y * TETRIMINO_SIZE])
            {
                tetris_point *point = &board[(active_piece.x + x) * HEIGHT + active_piece.y + y];
                point->r = 0;
                point->g = 0;
                point->b = 0;
                point->has_block = 0;
            }
        }
    }
}

void piece_to_board()
{
    for (int x = 0; x < TETRIMINO_SIZE; x++)
    {
        for (int y = 0; y < TETRIMINO_SIZE; y++)
        {
            if (tetriminos[active_piece.i][active_piece.rot][x + y * TETRIMINO_SIZE])
            {
                tetris_point *point = &board[(active_piece.x + x) * HEIGHT + active_piece.y + y];
                point->r = active_piece.r;
                point->g = active_piece.g;
                point->b = active_piece.b;
                point->has_block = 1;
            }
        }
    }
}

void draw_board()
{
    for (int i = 0; i < WIDTH * HEIGHT; i++)
    {
        set_rgb(BOARD_TO_PIXEL[i], board[i].r, board[i].g, board[i].b);
    }
    swap_buffers();
}

void update_board()
{
    clear_piece();
    active_piece.y++;
    uint collided = !check_pos_ok();
    if (collided)
    {
        active_piece.y--;
    }
    active_piece.collided = collided;
    piece_to_board();
}

void init_board()
{
    int offset = 0;
    int next_side_light_i = 0;

    for (int i = 0; i < WIDTH * HEIGHT; i++)
    {
        if (i + offset == SIDE_LIGHTS[next_side_light_i])
        {
            offset++;
            next_side_light_i++;
            if (next_side_light_i == SIDE_LIGHT_COUNT)
            {
                next_side_light_i--;
            }
        }
        int x = i % 10;
        int y = i / 10;
        if (y % 2)
        {
            x = 9 - x;
        }
        BOARD_TO_PIXEL[x * HEIGHT + y] = i + offset;
    }
    for (int i = 0; i < WIDTH * HEIGHT; i++)
    {
        board[i].r = 0;
        board[i].g = 0;
        board[i].b = 0;
        board[i].has_block = 0;
    }
}

void init_buttons()
{
    gpio_set_dir(left_pin, false);
    gpio_set_dir(right_pin, false);
    gpio_set_dir(down_pin, false);
    gpio_set_dir(rotate_pin, false);

    gpio_pull_up(left_pin);
    gpio_pull_up(right_pin);
    gpio_pull_up(down_pin);
    gpio_pull_up(rotate_pin);
}
