% Load face and non-face data and plot a few examples
load faces, load nonfaces
faces = double(faces); nonfaces = double(nonfaces);
% figure(1)
% colormap gray
% for k=1:25
%     subplot(5,5,k), imagesc(faces(:,:,10*k)), axis image, axis off
% end
% figure(2)
% colormap gray
% for k=1:25
%     subplot(5,5,k), imagesc(nonfaces(:,:,10*k)), axis image, axis off
% end
% Generate Haar feature masks
nbrHaarFeatures = 40;
haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);
% figure(3)
% colormap gray
% for k = 1:25
%     subplot(5,5,k),imagesc(haarFeatureMasks(:,:,k),[-1 2])
%     axis image,axis off
% end
% Create a training data set with a number of training data examples
% from each class. Non-faces = class label y=-1, faces = class label y=1

nbrTrainExamples = 300;
trainImages = cat(3,faces(:,:,1:nbrTrainExamples/2),nonfaces(:,:,1:nbrTrainExamples/2));
xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples/2), -ones(1,nbrTrainExamples/2)];


d = ones(1,nbrTrainExamples);
d(1:nbrTrainExamples) = 1 / nbrTrainExamples;

accuracies = [];

nClf = 40;
% clf = [threshold, polarity, featureIndex, alpha]
clfs = ones(4, nClf);

clf_range = 1:2:60

for nClf = clf_range
    % clf = [threshold, polarity, featureIndex, alpha]
    clfs = ones(4, nClf);
    % TRAIN MODEL
    for c = 1:nClf
        errMin = 1;
        polarity = 0;
        threshold = 0;
        featureIndex = 0;
        for n = 1:nbrHaarFeatures
            for t = 1:nbrTrainExamples
                err = 0;
                tao = xTrain(n, t);
                for m = 1:nbrTrainExamples
                    x = xTrain(n, m);
                    y = yTrain(m);
                    h = 1;
                    p = 1;
                    if p*x < p*tao
                        h = -1;
                    end
                    err = err + d(m)*(y ~= h);
                end
                if err > 0.5 && err < 1
                    p = -1;
                    err = 1 - err;
                end
                if err < errMin
                    polarity = p;
                    threshold = tao;
                    featureIndex = n;
                    errMin = err;
                end
            end
        end
        % Added small decimal value to make sure we don't divide by or take
        % the logarithm of zero
        alpha = 0.5*log((1.00001-errMin)/(errMin+0.00001));
        clfs(1:4, c) = [threshold, polarity, featureIndex, alpha];
        % Update weights
        dSum = 0;
        for m = 1:nbrTrainExamples
            h = 1;
            x = xTrain(featureIndex, m);
            y = yTrain(m);
            if polarity*x < polarity*threshold
                h = -1;
            end
            d(m) = d(m)*exp(-alpha*y*h);
            dSum = dSum + d(m);
        end
        for i = 1:nbrTrainExamples
            d(i) = d(i)/dSum;
        end
    end
    
    % Get the accuracy on training data using nClf weak classifiers
    correct = 0;
    for i = 1:nbrTrainExamples
        s = 0;
        for c = 1:nClf
            threshold = clfs(1, c);
            polarity = clfs(2, c);
            featureIndex = clfs(3, c);
            alpha = clfs(4, c);
            x = xTrain(featureIndex, i);
            h = 1;
            if polarity*x < polarity*threshold
                h = -1;
            end
            s = s + alpha*h;
        end
        y = yTrain(i);
        correct = correct + (sign(s) == y);
    end

    accuracy = correct / nbrTrainExamples
    accuracies = [accuracies, accuracy];
end

figure
title('Training error with different number of weak classifiers.')
xlabel('Number of weak classifiers')
ylabel('Training Error')
plot(clf_range, accuracies);
