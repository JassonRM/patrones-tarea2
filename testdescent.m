% Main entry code
%
% This is the script called to start the evaluation process

1;

# Objective function of the parameters theta
function res=J(theta,X,Y)
  order=length(theta)-1;
  ## First compute the residuals for all sets of theta
  R=(evalhyp(X, theta)-Y);
  ## Now square and sum the residuals for each set of theta
  res=0.5*sum(R.*R,1)';
endfunction;

# Gradient of J.
function res=gradJ(theta,X,Y)
  order = columns(theta)-1;
  XXo=bsxfun(@power,X,0:length(theta)-1);
  res=XXo'*(XXo*theta'-Y);
endfunction;

% Evaluate the hypothesis with all x given
function y=evalhyp(x,theta)
  XXo=bsxfun(@power,x,0:length(theta)-1);
  y=XXo*theta';
endfunction;

# Data stored each sample in a row, where the last row is the label
D=load("escazu40.dat");

# Extract the areas and the prices
Xo=D(:,1);
Yo=D(:,4);
t0 = [0 1 0.2]; ## Starting point
maxiter=20%2000;
maxerror=20;
minibatch=10; %%0.5*rows(Xo);
method="batch"; ## Method under evaluation

[thetas,errors]=descentpoly(@J,@gradJ,t0,Xo,Yo,0.005,
                            "method",method,
                            "maxiter",maxiter,
                            "minibatch",minibatch);

% plot everything
