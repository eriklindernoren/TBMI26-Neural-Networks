function plotFields(X,I)
  nx=100;%sum(X(2,:) == X(2,1));
  ny=100;%(X(3,:) == X(3,1));
  
  if(nx*ny ~= size(X,2))
     %Scattered data
     xi=linspace(min(X(1,:)),max(X(1,:)),300);
     yi=linspace(min(X(2,:)),max(X(2,:)),300);
     [XI,YI] = meshgrid(xi,yi);
     ZI = griddata(X(1,:),X(2,:),I,XI,YI);
     imagesc(xi,yi,ZI);
  else
     %Rectangular sample pattern
     imagesc(X(1,:),X(2,:),reshape(I,nx,ny));
  end
end
