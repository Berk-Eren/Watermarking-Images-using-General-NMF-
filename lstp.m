function [C] = lstp(A, B)
  n = size(A, 2);
  p = size(B, 1);

  l = lcm(n, p);
  C = kron(A, eye(l/n))*kron(B, eye(l/p));