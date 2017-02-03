function [ acc ] = calcAccuracy( cM )
%CALCACCURACY Takes a confusion matrix amd calculates the accuracy

correct = 0;
totalSamples = sum(sum(cM,1),2);
for i = 1:size(cM,1)
    correct = correct + cM(i,i);
end

acc = correct / totalSamples;

end

