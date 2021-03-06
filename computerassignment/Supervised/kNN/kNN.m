function [ labelsOut ] = kNN(X, k, Xt, Lt)
%KNN Your implementation of the kNN algorithm
%   Inputs:
%               X  - Features to be classified
%               k  - Number of neighbors
%               Xt - Training features
%               LT - Correct labels of each feature vector [1 2 ...]'
%
%   Output:
%               LabelsOut = Vector with the classified labels

labelsOut  = zeros(size(X,2),1);

classes = unique(Lt);
numClasses = length(classes);

% Iterate through the samples that should be classified
for i = 1:size(X,2)
  x = X(1, i);
  y = X(2, i);
  Xt1 = size(Xt);
  % Measure the distance to every samples among the observed data
  % save the distance and label of each observed sample
  for j = 1:size(Xt,2)
    xx = Xt(1, j);
    yy = Xt(2, j);
    d = pdist([x,y;xx,yy], 'euclidean');
    label = Lt(j);
    Xt1(j, 1) = d;
    Xt1(j, 2) = label;
  end
  % Sort the list by the samples distances
  Xt1 = sortrows(Xt1,1);
  % Fetch the k closest samples
  kv = Xt1(1:k,:);
  class = -1;
  maxcount = -1;
  % Get the vote among the k nearest neighbors
  for j = 1:size(classes)
    count = sum(kv(:,2) == classes(j));
    if count == 0
      continue;
    end
    % If we have a new majority vote => update class
    if count > maxcount
      class = classes(j);
      maxcount = count;
     % If we have an equal vote => choose the class of the closest
     % neighbor
    elseif count == maxcount
      new = kv((kv(:,2) == class),:);
      prev = kv((kv(:,2) == classes(j)),:);
      m = min([new;prev]);
      class = m(2);
    end
  end
  labelsOut(i) = class;
end


end

