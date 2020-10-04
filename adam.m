% Code taken from Pablo Alvarado's stoch_adam.m lines 217 to 250
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
% beta2: rmsprop constant
% epsilon: error tolerance

function [thetas, errors] = adam(J, gradJ, theta0, X, Y, lr, maxIter, MB, beta, beta2, epsilon)
  pkg load optim;

  ## Avoid division by zero
	rmspepsilon=1e-8;

  thetas = theta0; # sequence of thetas
	errors = J(theta0, X, Y);
  sample=round(unifrnd(1,rows(X),MB,1)); # Use MB random samples for init.
  gn = gradJ(theta0,X(sample,:),Y(sample));  # Gradient at current position
  s = gn.^2; # Initialize to avoid bias
  V = gn;

  j=0;
  for i=[1:maxIter] # max iterations
    tc = thetas(end,:); # Current position
    sample=round(unifrnd(1,rows(X),MB,1)); # Use MB random samples
    gn = gradJ(tc,X(sample,:),Y(sample));  # Gradient at current position
    s = beta2*s + (1-beta2)*(gn.^2);
    V = beta*V + (1-beta)*gn;
    gg = V./(sqrt(s + rmspepsilon) );

    tn = tc - lr * gg;      ## Gradient descent with filtered grad

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
