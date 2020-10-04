function hypothesis_evolution(tf,gtf,theta0,Xo,Yo,lr,name,varargin)
  % Plot the hypothesis function evolution during optimization

  ## normalizer_type="normal";
  normalizer_type="minmax";

  ## Normalize the data
  nx = normalizer(normalizer_type);
  X = nx.fit_transform(Xo);

  ## The outputs vector with the original data
  ny = normalizer(normalizer_type);
  Y = ny.fit_transform(Yo);

  [thetas,errors]=descentpoly(tf,gtf,theta0,Xo,Yo,lr,varargin{:});
  ## Limits for plot of regressed lines
  minArea = min(Xo);
  maxArea = max(Xo);
  minPrice = min(Yo);
  maxPrice = max(Yo);

  areas=linspace(minArea,maxArea,15); ## Some areas in the whole range
  nareas=nx.transform(areas'); ## Normalized desired areas

  ## We have to de-normalize the normalized estimation
  nprices = evalhyp(nareas, thetas(1,:));
  prices=ny.itransform(nprices);


  ## Plot training data
  figure("name", cstrcat("hypothesis evolution - ", name));
  xlabel("area");
  ylabel("precio");
  hold on;

  ## Plot initial hypothesis
  plot(areas, prices, "linewidth", 3);

  ## and now the intermediate versions
  for (i=[2:rows(thetas)])
    nprices = evalhyp(nareas, thetas(i,:));
    prices=ny.itransform(nprices);
    plot(areas,prices,'r',"linewidth",1);
  endfor;
  ## Repaint the last one as green
  plot(areas, prices, 'g', "linewidth", 3);
  plot(Xo,Yo,".b","markersize", 20);
endfunction
