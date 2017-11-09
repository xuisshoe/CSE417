function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2
    
    for k = 1:num_expts
        %generate data set
        [train_set, test_set] = generate_dataset( true_Q_f, N_train, N_test, var^0.5);
        %transfer trainig data to z space
        z2_train = computeLegPoly(train_set(:,1),2);
        z10_train = computeLegPoly(train_set(:,1),10);
        %linear regression to find best g2
        g2 = glmfit(z2, train_set(:,2), 'normal', 'constant', 'off');
        g10 = glmfit(z10, train_set(:,2), 'normal', 'constant', 'off');
        %transfer test data to z space
        z2_test = computeLegPoly(test_set(:,1),2);
        z10_test = computeLegPoly(test_set(:,1),10);
        %implement hypothesis in test set
        test2 = g2*z2_test;
        test10 = g10*z10_test;
        Eout2 = mean((test2(:,1)-test_set(:,2)).^2);
        Eout10 = mean((test10(:,1)-test_set(:,2)).^2);
        %calculate overfit measure
        overfit_m(i) = Eout10 - Eout2;
        
        
    end

end