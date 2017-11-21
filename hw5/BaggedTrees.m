function [ oobErr ] = BaggedTrees( X, Y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function
[n,m] = size(X);
trainingData = [X Y];
sampleInd = zeros(numBags, n);
trees = {};
for i=1:numBags
%     sampleData = datasample(trainingData, n);
    sampleInd(i,:) = datasample((1:n), n);
    sampleData = trainingData(sampleInd(i,:), :);
    trees{end + 1} = fitctree(sampleData(:, 1:m), sampleData(:,m+1));     
end
err = zeros(1,n);
for i=1:n
    res = [];
    for j=1:numBags
        if ~ismember(i, sampleInd(j,:))
            res = [res predict(trees{j}, X(i,:))];
        end
    end
    finalPredict = mode(res);
    if finalPredict ~= trainingData(i,end)
        err(i) = 1;
    end
end
oobErr = sum(err)/n;
end
