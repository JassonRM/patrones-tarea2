% Code taken from Pablo Alvarado's stoch_grad_descent.m lines 158 to 171
%
% The following parameters are required:
%
% J: target function computing the loss (or error)
% gradJ: gradient of target function
% theta0: initial point for the iteration
% Xo: vector holding the original data (e.g. the house areas)
% Yo: vector holding the original outputs (e.g. the house prices)
% lr: learning rate
function [thetas, errors] = stoch_grad_descent(J, gradJ, theta0, X, Y, lr, maxIter, epsilon)
	pkg load optim;

	## Perform the gradient descent
	thetas = theta0; # sequence of thetas
	errors = J(theta0, X, Y);

	for i=[1:maxIter] # max maxIter iterations
	  tc = thetas(end,:); # Current position
	  sample=round(unifrnd(1,rows(X))); # Use one random sample
	  gn = gradJ(tc,X(sample,:),Y(sample));  # Gradient at current position
	  tn = tc - lr * gn;# Next position
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
