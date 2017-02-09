function [Wout,Vout, trainingError, testError ] = trainMultiLayer(Xtraining,Dtraining,Xtest,Dtest, W0, V0,numIterations, learningRate )
%TRAINMULTILAYER Trains the network (Learning)
%   Inputs:
%               X* - Trainin/test features (matrix)
%               D* - Training/test desired output of net (matrix)
%               V0 - Weights of the output neurons (matrix)
%               W0 - Weights of the output neurons (matrix)
%               numIterations - Number of learning setps (scalar)
%               learningRate - The learningrate (scalar)
%
%   Output:
%               Wout - Weights after training (matrix)
%               Vout - Weights after training (matrix)
%               trainingError - The training error for each iteration
%                               (vector)
%               testError - The test error for each iteration
%                               (vector)

% Initiate variables
trainingError = nan(numIterations+1,1);
testError = nan(numIterations+1,1);
numTraining = size(Xtraining,2);
numTest = size(Xtest,2);
numClasses = size(Dtraining,1) - 1;
Wout = W0;
Vout = V0;

% Calculate initial error
Ytraining = runMultiLayer(Xtraining, W0, V0);
Ytest = runMultiLayer(Xtest, W0, V0);
trainingError(1) = sum(sum((Ytraining - Dtraining).^2))/(numTraining*numClasses);
testError(1) = sum(sum((Ytest - Dtest).^2))/(numTest*numClasses);

% Update the weights for numIterations iterations
for n = 1:numIterations

    S = Wout*Xtraining;
    U = [ones(1, size(tanh(S), 2)); tanh(S)];
    Y = Vout*U;

    % Calculate the gradient of the loss function with respect to the
    % weights v and w
    grad_v = (2/numTraining)*(Y - Dtraining)*U';
    grad_w = (2/numTraining)*((Vout'*(Y - Dtraining)).*(1.0000000001-U.^2))*Xtraining';
    
    % Update the weights
    Wout = Wout - learningRate * grad_w(2:end,:); %Take the learning step.
    Vout = Vout - learningRate * grad_v; %Take the learning step.

    Ytest = runMultiLayer(Xtest, Wout, Vout);
    trainingError(1+n) = sum(sum((Y - Dtraining).^2))/(numTraining*numClasses);
    testError(1+n) = sum(sum((Ytest - Dtest).^2))/(numTest*numClasses);
end

end

