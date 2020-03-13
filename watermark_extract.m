function C = watermark_extract(C_original, watermarked, iter, min_val, m, n)

    [A_wat, B_wat, step_wat] = factorize_matrix(watermarked, iter, m, n);
    C_watermarked = lstp(A_wat, B_wat);

    C = (C_watermarked - C_original)/min_val;