function x = ExtractHaarFeatures(images,haarFeatureMasks)
% x = ExtractHaarFeatures(images,haarFeatureMasks)
% 
% Applies a number of Haar features from a stack of images.
%
% Input:
%     images -  A stack of images saved in a 3D matrix, first
%     image in image(:,:,1), second in image(:,:,2) etc.
%
%     haarFeatureMasks - A stack of Haar feature filter masks saved in a 3D
%     matrix in the same way as the images. The haarFeatureMasks matrix is
%     typically obtained using the GenerateHaarFeatureMasks()-function
%
% Output:   
%     x - A feature matrix of size [nbrHaarFeatures,nbrOfImages] in which   
%     column k contains the result obtained when applying each Haar feature
%     filter to image k.
%
% Written by Ola Friman, 2012

% Check that images and Haar filters have the same size
if size(images,1) ~= size(haarFeatureMasks,1) | size(images,2) ~= size(haarFeatureMasks,2)
    error('Input image sizes do not match!')
end

% Get number of images and number of features to extract
nbrHaarFeatures = size(haarFeatureMasks,3);
nbrTrainingExamples = size(images,3);

% Initialize matrix with feature values
x = zeros(nbrHaarFeatures,nbrTrainingExamples);

% Extract features (using some Matlab magic to avoid one for-loop)
for k = 1:nbrHaarFeatures
    x(k,:) = permute(sum(sum(bsxfun(@times,images,haarFeatureMasks(:,:,k)),1),2),[1 3 2]);
end


% NOTE, the above for loop does the same as
%for k = 1:nbrHaarFeatures
%    for j = 1:nbrTrainingExamples
%        x(k,j) = sum(sum(images(:,:,j).*haarFeatureMasks(:,:,k)));
%    end
%end