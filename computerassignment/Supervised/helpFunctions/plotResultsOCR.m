function [ output_args ] = plotResultsOCR( Xt, Lt, LkNN )
%PLOTKNNRESULTSOCR Summary of this function goes here
%   Detailed explanation goes here


if size( Xt,1) == 65
    Xt = Xt(2:end,:);
end
samleNum = 1:size(Xt,2);
[tmp, ord] = sort(rand(1,size(Xt,2)));
figure(1003)
clf
for n = 1:16
    idx = ord(n);
    im = zeros(8,8);
    im(:) = Xt(1:end,idx);
    subplot(4,4,n)
    imagesc(im')
    colormap(gray)
    title(['L=' num2str(Lt(idx)-1) ', LkNN=' num2str(LkNN(idx)-1)])
end

end

