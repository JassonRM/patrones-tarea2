% Code taken from Pablo Alvarado's stoch_momentum.m lines 213 to 242
%
% The following parameters are required:
%
% J: target function computing the loss (or error)
% gradJ: gradient of target function
% theta0: initial point for the iteration
% Xo: vector holding the original data (e.g. the house areas)
% Yo: vector holding the original outputs (e.g. the house prices)
% lr: learning rate
% maxIter: maximum number of iterations
% MB: size of mini-batch
% beta: momentum constant
% epsilon: error tolerance

function [thetas, errors] = momentum(J, gradJ, theta0, X, Y, lr, maxIter, MB, beta, epsilon)
  pkg load optim;

  thetas=theta0; # sequence of t's
  errors = J(theta0, X, Y);
  sample=round(unifrnd(1,rows(X),MB,1)); # Use MB random samples for init.
  V = gradJ(theta0,X(sample,:),Y(sample));  # Gradient at current position

  j=0;
  for i=[1:maxIter] # max iterations
    tc = thetas(end,:); # Current position
    sample=round(unifrnd(1,rows(X),MB,1)); # Use MB random samples
    gn = gradJ(tc,X(sample,:),Y(sample));  # Gradient at current position

    V = beta*V + (1-beta)*gn; ## Filter the gradient
    tn = tc - lr * V;      ## Gradient descent with filtered grad

    err = norm(tc-tn);
	  thetas = [thetas;tn];
	  errors = [errors; err];

    if (err<epsilon)
      j=j+1;
      if (j>5) ## Only exit if several times the positions have been close enough
        break;
      endif;
    else
      j=0;
    endif;
  endfor

endfunction
