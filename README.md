To execute the methods, go into testdescent.m and modify the next parameters:

maxiter: maximum number of iterations before halt, default is 2000

maxerror: minimum tolerance required to halt execution, default is 0.001

lr: learning rate (alpha), default is 0.005

minibatch: size of mini batch, default is 5;

t0: Starting point for theta, default is [1 1 1].
        e.g: t0 = [5 0.2 0 1 3.4];

Methods: array of methods to execute, default is all methods.
        e.g: Methods={'batch' 'stochastic'};

Graphs: Plots to show, turn graph on by setting it to true, set it to false otherwise.
        Default is [true true true true];
        e.g: Graphs=[true false false false];

Ylimits: Max ylim for plot of multiple learning rates. Can not autoscale if method diverges.
        Default is [20 1 1 1 1];
        e.g: Ylimits = [15 0.1 1 0.1 1];


Run testdescent to view results.

File structure:
  Methods:
    - adam.m
    - batch_grad_descent.m
    - momentum.m
    - rmsprop.m
    - stoch_grad_descent.m
  Graphs:
    - cuadratic.m
    - hypothesis_evolution.m
    - multiple_alpha.m
    - multiple_orders.m
  Miscellaneous:
    - descentpoly.m
    - escazu40.dat
    - normalizer.m
