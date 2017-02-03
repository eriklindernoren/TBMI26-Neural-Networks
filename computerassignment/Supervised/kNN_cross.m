%% This script will help you test out your kNN code

%% Select which data to use:

% 1 = dot cloud 1
% 2 = dot cloud 2
% 3 = dot cloud 3
% 4 = OCR data

dataSetNr = 4; % Change this to load new data 

[X, D, L] = loadDataSet( dataSetNr );

% You can plot and study dataset 1 to 3 by running:
% plotCase(X,D)

plotCase(X,D);

%% Select a subset of the training features

numCrossBins = 3; % Number of Bins you want to devide your data into
numSamplesPerLabelPerCrossBin = 50; % Number of samples per label per bin, set to inf for max number (total number is numLabels*numSamplesPerBin)
selectAtRandom = true; % true = select features at random, false = select the first features

[ Xt, Dt, Lt ] = selectTrainingSamples(X, D, L, numSamplesPerLabelPerCrossBin, numCrossBins, selectAtRandom );

% Note: Xt, Dt, Lt will be cell arrays, to extract a bin from them use i.e.
% XBin1 = Xt{1};

%% Use kNN to classify data
% Note: you have to modify the kNN() function yourselfs.

% Set the number of neighbors
bestK = -1;
bestAcc = 0;

for k = 8:10
    totalAcc = 0;
    for i = 1:numCrossBins
        xTest = Xt{i};
        temp = Xt;
        temp([i]) = [];
        xTrain = cat(2, temp{1:end});
        
        lTest = Lt{i};
        temp = Lt;
        temp([i]) = [];
        lTrain = cat(1, temp{1:end});
        
        LkNN = kNN(xTest, k, xTrain, lTrain);

        % Calculate The Confusion Matrix and the Accuracy
        % Note: you have to modify the calcConfusionMatrix() function yourselfs.

        % The confucionMatrix
        cM = calcConfusionMatrix( LkNN, lTest);

        % The accuracy
        acc = calcAccuracy(cM);
        totalAcc = totalAcc + acc;
    end
    totalAcc = totalAcc / numCrossBins;
    k
    totalAcc
    if totalAcc > bestAcc
        bestK = k;
        bestAcc = totalAcc;
        disp(bestAcc)
    end
end

numTestBins = 2; % Number of Bins you want to devide your data into
numSamplesPerLabelPerTestBin = 100; % Number of samples per label per bin, set to inf for max number (total number is numLabels*numSamplesPerBin)

[ Xt, Dt, Lt ] = selectTrainingSamples(X, D, L, numSamplesPerLabelPerTestBin, numTestBins, selectAtRandom );

LkNN = kNN(Xt{2}, bestK, Xt{1}, Lt{1});

cM = calcConfusionMatrix( LkNN, Lt{2});

acc = calcAccuracy(cM);

bestK
acc


%% Plot classifications
% Note: You do not need to change this code.
if dataSetNr < 4
    plotkNNResultDots(Xt{2},LkNN,k,Lt{2},Xt{1},Lt{1});
else
    plotResultsOCR( Xt{2}, Lt{2}, LkNN )
end
