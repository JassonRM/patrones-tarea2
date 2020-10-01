% Code taken from Pablo Alvarado's batch_grad_descent.m lines 155 to 165
% The following parameters are required:
%
% tf: target function computing the loss (or error)
% gtf: gradient of target function
% theta0: initial point for the iteration
% Xo: vector holding the original data (e.g. the house areas)
% Yo: vector holding the original outputs (e.g. the house prices)
% lr: learning rate
function [thetas, errors] = batch_grad_descent(J, gradJ,theta0,X,Y,lr, maxIter, epsilon)
  ## Perform the gradient descent
  thetas = theta0; # sequence of thetas
  errors = J(theta0, X, Y);

  for i=[1:maxIter] # max maxIter iterations
    tc = thetas(end,:); # Current position
    gn = gradJ(tc,X,Y);  # Gradient at current position
    tn = tc - lr * gn; # Next position
    err = norm(gn);
    thetas = [thetas;tn];
    errors = [errors;err];

    if (err < epsilon) break; endif;
  endfor
endfunction
