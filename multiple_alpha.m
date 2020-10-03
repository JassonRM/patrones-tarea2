
function multiple_alpha(tf,gtf,theta0,Xo,Yo,y_lim,name,varargin)
  lr = [0.001 0.005 0.01 0.045 0.0494];
  colors = ['k' 'r' 'g' 'b' 'm'];
  figure("name", cstrcat("Error evolution - ",name));
  [thetas,errors]=descentpoly(tf,gtf,theta0,Xo,Yo,lr(1),varargin{:});
  plot(errors, colors(1), "linewidth", 2);

  Legend=cell(5,1);
  Legend{1} = strcat('alpha = ', num2str(lr(1)));
  xlabel('iterations');
  ylabel('error');
  axis tight;
  ylim([0 y_lim]);
  hold on;

  for i=2:numel(lr)
    [thetas,errors]=descentpoly(tf,gtf,theta0,Xo,Yo,lr(i),varargin{:});
    plot(errors, colors(i), "linewidth", 2);
    Legend{i} = strcat('alpha = ', num2str(lr(i)));
  endfor
  hold off;
  legend(Legend);
endfunction
