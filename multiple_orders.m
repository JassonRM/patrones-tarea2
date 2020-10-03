function multiple_orders(tf,gtf,Xo,Yo,lr,name,varargin)
  t1 = [0 0];
  t3 = [0 0 0 0];
  t5 = [0 0 0 0 0 0];
  t7 = [0 0 0 0 0 0 0 0];

  Legends = cell(5,1);

  figure("name", cstrcat("Multi-order polinomial - ",name));
  plot(Xo,Yo,".k","linewidth", 1, "markersize", 15, "marker",'o', 'markerfacecolor', [247 176 91]/255,'markeredgecolor', 'k');
  hold on;
  Legends{1} ="data";

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
  plot(areas,prices,'k',"linewidth",3, "color", [108, 117, 125]/255);
  Legends{2} ="n=1";

  [thetas,errors]=descentpoly(tf,gtf,t3,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'k',"linewidth",3,"color", [33, 37, 41]/255);
  Legends{3} ="n=3";

  [thetas,errors]=descentpoly(tf,gtf,t5,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'k',"linewidth",3,"color", [73, 80, 87]/255);
  Legends{4} ="n=5";

  [thetas,errors]=descentpoly(tf,gtf,t7,Xo,Yo,lr,varargin{:});
  nprices = evalhyp(nareas, thetas(end,:));
  prices=ny.itransform(nprices);
  plot(areas,prices,'k',"linewidth",3,"color", [52, 58, 64]/255);
  Legends{5} ="n=7";

  legend(Legends);

  hold off;

endfunction
