function multiple_orders(tf,gtf,Xo,Yo,lr,varargin)
  t1 = [0 0];
  t3 = [0 0 0 0];
  t5 = [0 0 0 0 0 0];
  t7 = [0 0 0 0 0 0 0 0];

  figure(2);
  plot(Xo,Yo,".b","markersize", 20);
  hold on;

  minArea = min(Xo);
  maxArea = max(Xo);
  minPrice = min(Yo);
  maxPrice = max(Yo);
  ylim([minPrice maxPrice]);
  xlim([minArea maxArea]);

  ## normalizer_type="normal";
  normalizer_type="minmax";

  ## Normalize the data
  nx = normalizer(normalizer_type);
  X = nx.fit_transform(Xo);

  ## The outputs vector with the original data
  ny = normalizer(normalizer_type);
  Y = ny.fit_transform(Yo);

  areas=linspace(minArea,maxArea,150); ## Some areas in the whole range
  nareas=nx.transform(areas'); ## Normalized desired areas

  [thetas,errors]=descentpoly(tf,gtf,t1,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'r',"linewidth",3);
  [thetas,errors]=descentpoly(tf,gtf,t3,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'r',"linewidth",3);
  [thetas,errors]=descentpoly(tf,gtf,t5,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'r',"linewidth",3);
  [thetas,errors]=descentpoly(tf,gtf,t7,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'r',"linewidth",3);
  hold off;

endfunction
