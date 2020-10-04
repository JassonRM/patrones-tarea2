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
  res=(XXo'*(XXo*theta'-Y))';
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

maxiter=2000;
maxerror=0.001;
lr=0.005;
minibatch=5;
t0 = [1 1 1]; ## Starting point

Methods={'batch' 'stochastic' 'momentum' 'rmsprop' 'adam'}; ## Method under evaluation
Ylimits=[20 1 1 1 1]; ## Graph limits
Graphs=[true true true true]; ## Plots to show in the order:
                                ##(cuadratic, hypothesis_evolution, multiple_alpha, multiple_orders)

i=1;
for method=Methods

  if(Graphs(1))
    cuadratic(@J,@gradJ,t0, Xo,Yo,lr,method{1},
                              "method",method{1},
                              "maxiter",maxiter,
                              "minibatch",minibatch,
                              "epsilon", maxerror);
  endif
  if(Graphs(2))
    hypothesis_evolution(@J,@gradJ,t0, Xo,Yo,lr,method{1},
                              "method",method{1},
                              "maxiter",maxiter,
                              "minibatch",minibatch,
                              "epsilon", maxerror);
  endif
  if(Graphs(3))
    multiple_alpha(@J,@gradJ,t0,Xo,Yo,Ylimits(i),method{1},
                              "method",method{1},
                              "maxiter",maxiter,
                              "minibatch",minibatch,
                              "epsilon", maxerror);
  endif
  if(Graphs(4))
    multiple_orders(@J,@gradJ,Xo,Yo,lr,method{1},
                              "method",method{1},
                              "maxiter",maxiter,
                              "minibatch",minibatch,
                              "epsilon", maxerror);
  endif
  i++;
endfor
