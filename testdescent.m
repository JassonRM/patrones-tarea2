% Main entry code
%
% This is the script called to start the evaluation process

1;

# Objective function of the parameters theta
function res=J(theta,X,Y)
  order=length(theta)-1;

  ## ################################################################
  ## Your code in here!!!

  res = zeros(length(theta),1); ## Dummy result
endfunction;

# Gradient of J.
function res=gradJ(theta,X,Y)
  order = columns(theta)-1;

  ## ################################################################
  ## Your code in here!!!

  res = rand(size(theta));
endfunction;

% Evaluate the hypothesis with all x given
function y=evalhyp(x,theta)
  XX=bsxfun(@power,x,0:length(theta)-1);
  y=XX*theta;
endfunction;

# Data stored each sample in a row, where the last row is the label
D=load("escazu40.dat");

# Extract the areas and the prices
Xo=D(:,1);
Yo=D(:,4);

## ################################################################
## Your code in here!!!
##
## Next lines are just an example.  You should change them

t0 = [0 1 0.2]; ## Starting point
maxiter=2000;
maxerror=20;
minibatch=10; %%0.5*rows(Xo);
method="batch"; ## Method under evaluation


[thetas,errors]=descentpoly(@J,@gradJ,t0,Xo,Yo,0.005,
                            "method",method,
                            "maxiter",maxiter,
                            "minibatch",minibatch);
