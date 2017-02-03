function [ Xt, Dt, Lt ] = selectTrainingSamples(XtAll, DtAll, LtAll, numSamples, numBins, selectAtRandom )
%SELECTTRAININGSAMPLES Summary of this function goes here
%   Detailed explanation goes here

labels = unique(LtAll(:)');
numLabels = length(labels);

[n, b] = hist(LtAll,labels);

Xt = {};
Dt = {};
Lt = {};
if isinf(numSamples)
    numSamples = floor(min(n)/numBins);
end

if selectAtRandom
    for m = 1:numBins
        Xt{m} = [];
        Dt{m} = [];
        Lt{m} = [];
        for n = 1:numLabels
            labelInds = find(LtAll == labels(n));
            rnd = rand(1,length(labelInds));
            [~,ord] = sort(rnd);

            inds = labelInds(ord(1:numSamples));
            Xt{m} = [Xt{m} XtAll(:,inds)];
            Dt{m} = [Dt{m} DtAll(:,inds)];
            Lt{m} = [Lt{m}; LtAll(inds)];
            XtAll(:,inds) = [];
            DtAll(:,inds) = [];
            LtAll(inds)  = [];
        end
    end
else
    
    for m = 1:numBins
        Xt{m} = [];
        Dt{m} = [];
        Lt{m} = [];
        for n = 1:numLabels
        
            labelInds = find(LtAll == labels(n));

            inds = labelInds(1:numSamples);

            Xt{m} = [Xt{m} XtAll(:,inds)];
            Dt{m} = [Dt{m} DtAll(:,inds)];
            Lt{m} = [Lt{m}; LtAll(inds)];
            XtAll(:,inds) = [];
            DtAll(:,inds) = [];
            LtAll(inds)  = [];
        end
    end
end
end


