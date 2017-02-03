function [ ] = plotkNNResultDots(X,LkNN,k,L,Xt,Lt)
%PLOTKNNRESULTDOTS Summary of this function goes here
%   Detailed explanation goes here

%Test on region and plot
nx=60;%sum(X(2,:) == X(2,1));
ny=60;%(X(3,:) == X(3,1));
 %Scattered data
 xi=linspace(min(X(1,:))-1,max(X(1,:))+1,nx);
 yi=linspace(min(X(2,:))-1,max(X(2,:))+1,ny);

 [XI,YI] = meshgrid(xi,yi);

I = kNN([XI(:)';YI(:)'], k, Xt, Lt);
Lt2 = kNN(Xt, k, Xt, Lt);
figure(1001);clf
imagesc(xi,yi,reshape(I,[nx ny]))
colormap(gray)

figure(1002);clf
imagesc(xi,yi,reshape(I,[nx ny]))
colormap(gray)
%%
figure(1001);
title('Test data result (green ok, red error)');
plotData(X,L,LkNN); hold off;

figure(1002);
title('Training Data');
plotData(Xt,Lt,Lt2); hold off;

end

