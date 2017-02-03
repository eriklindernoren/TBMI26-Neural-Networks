function [ Xt, Dt, Lt, Xtest, Dtest, Ltest ] = selectTrainingAndTestSamples(XtAll, DtAll, LtAll, numSamples, selectAtRandom )
%SELECTTRAININGSAMPLES Summary of this function goes here
%   Detailed explanation goes here

labels = unique(LtAll(:)');
numLabels = length(labels);


if isinf(numSamples)
    n = hist(LtAll,labels);
    numSamples = min(n);
end

numTraining = round(numSamples/2);
Xt = [];
Dt = [];
Lt = [];
Xtest = [];
Dtest = [];
Ltest = [];
if selectAtRandom
    for n = 1:numLabels
        labelInds = find(LtAll == labels(n));
        rnd = rand(1,length(labelInds));
        [~,ord] = sort(rnd);

        inds = labelInds(ord(1:numSamples));

        Xt = [Xt XtAll(:,inds(1:numTraining))];
        Dt = [Dt DtAll(:,inds(1:numTraining))];
        Lt = [Lt; LtAll(inds(1:numTraining))];
        Xtest = [Xtest XtAll(:,inds(1+numTraining:end))];
        Dtest = [Dtest DtAll(:,inds(1+numTraining:end))];
        Ltest = [Ltest; LtAll(inds(1+numTraining:end))];
    end
else
    for n = 1:numLabels
        labelInds = find(LtAll == labels(n));

        inds = labelInds(1:numSamples);

        Xt = [Xt XtAll(:,inds(1:numTraining))];
        Dt = [Dt DtAll(:,inds(1:numTraining))];
        Lt = [Lt; LtAll(inds(1:numTraining))];
        Xtest = [Xtest XtAll(:,inds(1+numTraining:end))];
        Dtest = [Dtest DtAll(:,inds(1+numTraining:end))];
        Ltest = [Ltest; LtAll(inds(1+numTraining:end))];

    end
end



end

