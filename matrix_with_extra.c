#include "matrix_with_extra.h"

uint matrix_set_rgb(matrix_with_extra *m, uint i, uint r, uint g, uint b)
{
    set_rgb(m->matrix_to_pix[i], r, g, b);
}

uint init_matrix_with_extra(matrix_with_extra *m, const uint *extra_index, uint extra_count)
{
    int offset = 0;
    int next_extra_i = 0;

    for (int i = 0; i < m->w * m->h; i++)
    {
        if (i + offset == extra_index[next_extra_i])
        {
            offset++;
            next_extra_i++;
            if (next_extra_i == extra_count)
            {
                next_extra_i--;
            }
        }
        int x = i % m->w;
        int y = i / m->w;
        if (y % 2)
        {
            x = m->w - 1 - x;
        }
        m->matrix_to_pix[x * m->h + y] = i + offset + m->offset;
    }
}