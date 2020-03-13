function [A, B] = inverse_lstp(sizes, W, H)

    a_step = sizes(1);
    b_step = sizes(2);

    A_row = size(W, 1)/a_step; 
    A_col = size(W, 2)/a_step;
    
    B_row = size(H, 1)/b_step;
    B_col = size(H, 2)/b_step;
    
    A = zeros(A_row, A_col);
    B = zeros(B_row, B_col);
    
    for i = 0:A_row-1
        for j = 0:A_col-1
            A(i + 1, j + 1) = mean(diag(W(i*a_step+1:i*a_step+a_step, j*a_step+1:j*a_step+a_step)));
        end
    end
    
    for i = 0:B_row-1
        for j = 0:B_col-1
            B(i + 1, j + 1) = mean(diag(H(i*b_step+1:i*b_step+b_step, j*b_step+1:j*b_step+b_step)));
        end
    end