function [C, val] = watermark_embed(basis, coeff, watermark)

    n = size(basis, 1);
    p = size(coeff, 2);
    l = lcm(n, p);
    
    gener = l/n;
    
    [val, i] = find_min(basis);
    
    i = i - 1;
    j = 0;
    
    coeff(i*gener+1:i*gener+gener, j*gener+1:j*gener+gener) = watermark;
    
    C = lstp(basis, coeff);