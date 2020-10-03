function cuadratic(tf,gtf,theta0,Xo,Yo,lr,name,varargin)
  [thetas,errors]=descentpoly(tf,gtf,theta0,Xo,Yo,lr,varargin{:});
  if(columns(thetas)==3)
    figure("name", cstrcat("Theta trayectory for a quadratic approximation - ", name));
    scatter3(thetas(:,1), thetas(:,2), thetas(:,3));
  endif;
endfunction
