#include "tetris.h"

#define HOLD_BUTTON_CODE 32
#define LEFT_BUTTON_CODE 4
#define RIGHT_BUTTON_CODE 1
#define DOWN_BUTTON_CODE 2
#define ROTATE_BUTTON_CODE 64

piece active_piece, next_piece, hold_piece;

tetris_point board[MAIN_MATRIX_W * MAIN_MATRIX_H];

uint score;
uint64_t last_frame;
uint speed;
uint speed_up_factor;

uint tetriminos[TETRIMINO_COUNT][TETRIMINO_ROTATIONS][TETRIMINO_SIZE * TETRIMINO_SIZE] = {
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

uint8_t last_button_state;

#define COOL_COLOR_COUNT 7
typedef struct col
{
    uint16_t r, g, b;
} col;

col COOL_COLORS[COOL_COLOR_COUNT] = {
    {0, 0, 0xFF},
    {0, 0xFF, 0},
    {0xFF, 0, 0},
    {0, 0xFF, 0xFF},
    {0xFF, 0, 0xFF},
    {0xFF, 0xFF, 0},
    {0xFF, 0xFF, 0xFF},
};

void update_board();
void draw_board();
void init_board();
void clear_piece();
void piece_to_board();
uint check_pos_ok();
uint check_scoring();
void piece_to_secondary_display(matrix_with_extra *display, piece *p);
void init_random_tetrimino(piece *out);
uint check_game_over();

void tetris_init()
{
    score = 0;
    last_frame = 0;
    speed = 500000;
    speed_up_factor = 0;
    last_button_state = 0xFF;
    init_board();
    init_random_tetrimino(&active_piece);
    piece_to_board();
    init_random_tetrimino(&next_piece);
    init_random_tetrimino(&hold_piece);
    piece_to_secondary_display(&next_piece_matrix, &next_piece);
    piece_to_secondary_display(&hold_piece_matrix, &hold_piece);
}

uint tetris_update()
{
    uint64_t time = to_us_since_boot(get_absolute_time());
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
            if (got_rows)
            {
                scoreboard_set_score(score, 0);
            }
            active_piece = next_piece;
            init_random_tetrimino(&next_piece);
            if (!check_pos_ok())
            {
                return 1;
            }
        }
        piece_to_secondary_display(&hold_piece_matrix, &hold_piece);
        piece_to_secondary_display(&next_piece_matrix, &next_piece);
    }
    return 0;
}

uint check_scoring()
{
    uint scored_rows = 0;
    for (uint y = 0; y < main_matrix.h; y++)
    {
        uint all_up = 1;
        for (uint x = 0; x < main_matrix.w; x++)
        {
            if (!board[x * main_matrix.h + y].has_block)
            {
                all_up = 0;
            }
        }
        if (all_up)
        {
            scored_rows++;
            for (uint x = 0; x < main_matrix.w; x++)
            {
                tetris_point *point = &board[x * main_matrix.h + y];
                point->has_block = 0;
                point->r = 0;
                point->g = 0;
                point->b = 0;
            }
            for (int yy = y - 1; yy >= 0; yy--)
            {
                for (int x = 0; x < main_matrix.w; x++)
                {
                    tetris_point *source_point = &board[x * main_matrix.h + yy];
                    tetris_point *target_point = &board[x * main_matrix.h + yy + 1];
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

void init_random_tetrimino(piece *out)
{
    col c = COOL_COLORS[rand() % COOL_COLOR_COUNT];
    out->r = c.r;
    out->g = c.g;
    out->b = c.b;
    out->rot = rand() % 4;
    out->x = rand() % (main_matrix.w - TETRIMINO_SIZE);
    out->i = rand() % TETRIMINO_COUNT;
    out->collided = 0;
    out->y = 0;
}

void tetris_rotate_piece()
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
                if (board_x < 0 || board_x >= main_matrix.w)
                {
                    return 0;
                }
                if (board_y < 0 || board_y >= main_matrix.h)
                {
                    return 0;
                }
                if (board[board_x * main_matrix.h + board_y].has_block)
                {
                    return 0;
                }
            }
        }
    }
    return 1;
}

void tetris_move_x(int dx)
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
                tetris_point *point = &board[(active_piece.x + x) * main_matrix.h + active_piece.y + y];
                point->r = 0;
                point->g = 0;
                point->b = 0;
                point->has_block = 0;
            }
        }
    }
}

void piece_to_secondary_display(matrix_with_extra *display, piece *p)
{
    for (int i = 0; i < TETRIMINO_SIZE * TETRIMINO_SIZE; i++)
    {
        if (tetriminos[p->i][p->rot][i])
        {
            matrix_set_rgb(display, i, p->r, p->g, p->b);
        }
        else
        {
            matrix_set_rgb(display, i, 0, 0, 0);
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
                tetris_point *point = &board[(active_piece.x + x) * main_matrix.h + active_piece.y + y];
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
    for (int i = 0; i < main_matrix.w * main_matrix.h; i++)
    {
        matrix_set_rgb(&main_matrix, i, board[i].r, board[i].g, board[i].b);
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
    for (int i = 0; i < main_matrix.w * main_matrix.h; i++)
    {
        board[i].r = 0;
        board[i].g = 0;
        board[i].b = 0;
        board[i].has_block = 0;
    }
}

void tetris_button_action(uint8_t state)
{
    uint8_t pressed_buttons = ~state & last_button_state;
    if (pressed_buttons & DOWN_BUTTON_CODE)
    {
        tetris_drop_piece();
    }
    if (pressed_buttons & LEFT_BUTTON_CODE)
    {
        tetris_move_x(1);
    }
    if (pressed_buttons & RIGHT_BUTTON_CODE)
    {
        tetris_move_x(-1);
    }
    if (pressed_buttons & ROTATE_BUTTON_CODE)
    {
        tetris_rotate_piece();
    }
    if (pressed_buttons & HOLD_BUTTON_CODE)
    {
        tetris_swap_hold();
    }
    last_button_state = state;
}

void tetris_swap_hold()
{
    piece tmp = active_piece;
    clear_piece();
    active_piece = hold_piece;
    piece_to_board();
    hold_piece = tmp;
    piece_to_secondary_display(&hold_piece_matrix, &hold_piece);
    hold_piece.y = 0;
}

void tetris_drop_piece()
{
    while (!active_piece.collided)
    {
        update_board();
    }
}
