function [val, index] = find_min(matrix)
    
    matrix(matrix==0)=inf;
    val = min(matrix, [], 'all');
    index = find(matrix==val);