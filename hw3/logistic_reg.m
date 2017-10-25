function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)


[N,m] = size(X);
X = [ones(N,1) X];
y = 2*y - 1;
w = zeros(1,m+1);
i = 0;

for i = 1:max_its
    h = w*X.';
    e_in = sum(log(1+exp((-y.').*h)))/N;
    gt = -sum((y.*X)./(1+exp(transpose((y.').*h))))/N;
    if norm(gt) < 0.000001
        disp(i);
        break;
    end
    vt = -1*gt;
    w = w + eta*vt;
    
end

    
end

