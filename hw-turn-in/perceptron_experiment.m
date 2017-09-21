function [ num_iters bounds] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bounds is the theoretical bound on the # of iterations
%              for each sample
%      (both the outputs should be num_samples long)
% N = 100; d = 10+1;
 R = zeros(1,num_samples);
 w_abs = zeros(1,num_samples);
 p = zeros(1,num_samples);
 bounds = zeros(1,num_samples);
 num_iters = zeros(1,num_samples);
 
 for h = 1:num_samples
     
    w0 = [0,rand(1,d)];
    x = -1 + (1 + 1) * rand(d + 1,N);
    x(1,:) = 1; 
    y = sign(w0 * x);
    data_in = [x;y];
    [ w,iterations ] = perceptron_learn( data_in );
    num_iters(h) = iterations;
    R(h) = max(sum(x));
    w_abs(h) = norm(w0); 
    p(h) =  y*(w0*x)';
    bounds(h) = ((R(h) * w_abs(h))/ p(h))^2;  
 
 end
    
 diff = num_iters - bounds;
 histogram(num_iters);
 histogram(log(diff));
 
end

