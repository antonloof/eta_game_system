#pragma once
#include "pico/stdlib.h"
#include "tls3001.h"

typedef struct
{
    const uint w, h, offset;
    uint *matrix_to_pix;
} matrix_with_extra;

uint matrix_set_rgb(matrix_with_extra *m, uint i, uint r, uint g, uint b);
uint init_matrix_with_extra(matrix_with_extra *m, const uint *extra_index, uint extra_count);