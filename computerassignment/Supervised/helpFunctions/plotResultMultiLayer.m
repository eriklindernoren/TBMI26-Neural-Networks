function [ ] = plotResultMultiLayer(W,V,Xt,Lt,LSingleLayerTraining,Xtest,Ltest,LSingleLayerTest)
%PLOTKNNRESULTDOTS Summary of this function goes here
%   Detailed explanation goes here

%Test on region and plot
nx=60;%sum(X(2,:) == X(2,1));
ny=60;%(X(3,:) == X(3,1));
%Scattered data
xi=linspace(min(Xt(2,:))-1,max(Xt(2,:))+1,nx);
yi=linspace(min(Xt(3,:))-1,max(Xt(3,:))+1,ny);

[XI,YI] = meshgrid(xi,yi);
[ ~,I ] = runMultiLayer([ones(1,length(XI(:)));XI(:)';YI(:)'], W, V);


%%
figure(1103);clf
imagesc(xi,yi,reshape(I,[nx ny]))
colormap(gray)
title('Training data result (green ok, red error)');
plotData(Xt(2:3,:),Lt,LSingleLayerTraining); hold off;
%%
figure(1104);clf
imagesc(xi,yi,reshape(I,[nx ny]))
colormap(gray)
title('Test data result (green ok, red error)');
plotData(Xtest(2:3,:),Ltest,LSingleLayerTest); hold off;
end

