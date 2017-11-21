function [ train_errlist, test_errlist ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use
trees = {};
[n, m] = size(X_tr);
weights = zeros(1,n_trees);
d = ones(1, n)/n;

for i=1:n_trees
    trees{end + 1} = fitctree(X_tr, y_tr,'SplitCriterion','deviance', 'Weights', d, 'minparent',size(X_tr,1),'prune','off');
    pred = predict(trees{i}, X_tr);
    et = 0;
    for j=1:n
        if pred(j) ~= y_tr(j)
            et = et + 1*d(j);
        end
    end
    
    weights(i) = log((1-et)/et)/2;
    for j=1:n
        d(j) = d(j)*exp(-weights(i)*y_tr(j)*pred(j));
    end
    d = d/sum(d);
end

train_errlist = zeros(1,n_trees);
train_err = 0;
for k=1:n_trees
    for i=1:n
        res = zeros(k,1);
        for j=1:k
            res(j) = predict(trees{j}, X_tr(i,:));
        end
        g = sign(weights(1:k)*res);
        if g ~= y_tr(i)
            train_err = train_err + 1;
        end
    end
    train_err = train_err/n;
    train_errlist(k) = train_err;
end



[nt, mt] = size(X_te);
test_errlist = zeros(1,n_trees);
test_err = 0;
for k=1:n_trees
    for i=1:nt
        res_test = zeros(k, 1);
        for j=1:k
            res_test(j) = predict(trees{j}, X_te(i,:));
        end
        gt = sign(weights(1:k)*res_test);
        if gt ~= y_te(i)
            test_err = test_err + 1;
        end
    end
    test_err = test_err/nt;
    test_errlist(k) = test_err;
end



end

