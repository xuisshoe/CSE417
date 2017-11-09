function [ train_set test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair

    %Parameter set-up
    n = 0:Q_f; % Max number of iteration
    norm_factor = sqrt(sum(1./(2*n+1))); % Normalize factor
    % calculate according y value
    yTrain = computeLegPoly(2*rand([N_train 1])-1, Q_f)*norm_factor;
    yTest = computeLegPoly(2*rand([N_test 1])-1, Q_f)*norm_factor;
    % reform y train using y = f(x) + sigma*epsilon 
    yTrain = yTrain + sigma*normrnd(0,1,[length(yTrain),1]);
    
    %generate trainig set, X are random data sets
    train_set = [2*rand([N_train 1])-1 yTrain];
    test_set = [2*rand([N_test 1])-1 yTest];

end
