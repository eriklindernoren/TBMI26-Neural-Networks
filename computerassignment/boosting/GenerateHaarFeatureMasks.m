function haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures)
%   haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures)
%   
%   Generate a random set of filter masks for Haar feature extraction. 
%   The masks will be of random sizes (within certain limits), at random
%   locations, and of random direction (aligned along x or y).
%   Both first order ([-1 1]-type) and second order features
%   ([-1 2 -1]-type) are generated.
% 
%   The default size of 24x24 is assumed (can easily be changed below).
%
%   Input:
%           nbrHaarFeatures - Number of Haar feature masks to generate
%
%   Output: 
%           haarFeatureMasks - A [24 x 24 x nbrHaarFeatures] matrix with
%                              the Haar filter masks
% 
%   Written by Ola Friman, 2012

% We assume that the image size is 24x24 to reduce the
% number of input parameters.
imgSizex = 24;    % Equal to number of columns
imgSizey = 24;    % Equal to number of rows

% Intialize mask matrix
haarFeatureMasks = zeros(imgSizey,imgSizex,nbrHaarFeatures);

% Create feature masks one at the time
for k = 1:nbrHaarFeatures
    
    % Randomize 1:st or 2:nd derivative type of Haar feature
    featureType = rand > 0.5;         
    
    % Randomize direction (x or y) of the filter 
    featureDirection = rand > 0.5;    
        
    if featureType == 0   % 1:st derivative type
        % Size of one field of the feature. For the 1:st deriviative
        % type, there are 2 fields, i.e., the actual size is twice as big
        xSize = floor(2 + rand*8);
        ySize = floor(2 + rand*8);  % Size between 2x(2 and 9)
        
        % Find random origin so that the feature fits within the image
        xOriginMax = imgSizex - 2*xSize + 1;
        yOriginMax = imgSizey - 2*ySize + 1;
        xOrigin = 1+floor(rand*xOriginMax);
        yOrigin = 1+floor(rand*yOriginMax);
        
        % Generate feature
        if featureDirection == 0   % x-direction
            haarFeatureMasks(yOrigin:yOrigin+2*ySize-1, xOrigin:xOrigin+xSize-1,k) = -1;
            haarFeatureMasks(yOrigin:yOrigin+2*ySize-1, xOrigin+xSize:xOrigin+2*xSize-1,k) = 1;
        else                       % y-direction
            haarFeatureMasks(yOrigin:yOrigin+ySize-1         ,xOrigin:xOrigin+2*xSize-1,k) = -1;
            haarFeatureMasks(yOrigin+ySize:yOrigin+2*ySize-1 ,xOrigin:xOrigin+2*xSize-1,k) = 1;
        end
        
    elseif featureType == 1   % 2:nd derivative type
        % Size of one field of the feature. For the 1:st deriviative
        % type, there are 2 fields, i.e., the actual size is twice as big
        xSize = floor(2 + rand*5);
        ySize = floor(2 + rand*5);   % Size between 3x(2 and 6)
        
        % Find random origin so that the feature fits within the image
        xOriginMax = imgSizex - 3*xSize + 1;
        yOriginMax = imgSizey - 3*ySize + 1;
        xOrigin = 1+floor(rand*xOriginMax);
        yOrigin = 1+floor(rand*yOriginMax);
        
        % Generate feature
        if featureDirection == 0   % x-direction
            haarFeatureMasks(yOrigin:yOrigin+3*ySize-1, xOrigin:xOrigin+xSize-1,k) = -1;
            haarFeatureMasks(yOrigin:yOrigin+3*ySize-1, xOrigin+xSize:xOrigin+2*xSize-1,k) = 2;
            haarFeatureMasks(yOrigin:yOrigin+3*ySize-1, xOrigin+2*xSize:xOrigin+3*xSize-1,k) = -1;
        else                       % y-direction
            haarFeatureMasks(yOrigin:yOrigin+ySize-1           ,xOrigin:xOrigin+3*xSize-1,k) = -1;
            haarFeatureMasks(yOrigin+ySize:yOrigin+2*ySize-1   ,xOrigin:xOrigin+3*xSize-1,k) = 2;
            haarFeatureMasks(yOrigin+2*ySize:yOrigin+3*ySize-1 ,xOrigin:xOrigin+3*xSize-1,k) = -1;
        end
    end
end

