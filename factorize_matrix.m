function [A, B, steps] = factorize_matrix(Img, iter, m, n)

  alpha = 10.^(-5)*9;
  
  height = size(Img, 1);
  width = size(Img, 2);

  gener = height/m;
  p = n*gener;

  A = rand(m, n);
  B = rand(p, (p*width*m)/(n*height));
  C = Img;
  
  l = lcm(n, p);
  
  a_step = l/n;
  b_step = l/p;
  steps = [a_step, b_step];
  
  A = lstp(A, eye(a_step));
  B = lstp(B, eye(b_step));
  
  for k=1:iter
    a_lstp_b = lstp(A, B);
    a_upd = lstp(C, B')./(lstp(a_lstp_b, B') + alpha);
    A = A.*a_upd;

    a_lstp_b = lstp(A, B);
    b_upd = lstp(A', C)./(lstp(A', a_lstp_b) + alpha);
    B = B.*b_upd;
  end