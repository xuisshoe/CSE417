function [ w iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Inputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for

%%%%%%%%%%%%%%%%%%%%% 1st step : Generating inintial weight and data for training. %%%%%%%%%%%%%%%%%%%%%
 
w_1 = zeros(1,11); % Set up the weight vector, starting to be zero.
iterations = 0; % Set up the iteration counter.
x_1 = data_in(1:11,:); 
y_1 = data_in(12,:);
[d,N] = size(data_in); % Acquirng the number of experiment N and the number of dimension d.
i = 1; % Set up a counter for comparison.
t = 1;
done = 0;

while not(done)
    done = 1;
    for n = 1:N
        h = sign(w_1*x_1); % Find the hypothesis set h.
        if h(n) ~= y_1(n)
            w_2 = w_1 + (x_1(:,n) * y_1(n))';
            done = 0;
        end
    end
    w_1 = w_2;
    t = t + 1;
end

w = w_1;
iterations = t;

end
        
    