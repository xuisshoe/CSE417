%Script that runs the set of necessary experiments. This is an example that
%you can use; you should change it as appropriate to answer the question to
%your satisfaction.
clc
clear

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

expt_data_mat = zeros(length(Q_f), length(N), length(var));
expt_data_mat2 = zeros(length(Q_f), length(N), length(var));

num_expts = 500;
n = 0;

for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            err_dat = computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),num_expts);
            expt_data_mat(ii,jj,kk) = median(err_dat);
            expt_data_mat2(ii,jj,kk) = mean(err_dat);
            n = n+1
        end
    end
    
    fprintf('.');
end

%% plot overfit vs N, fix Q_f, median
figure(1)
plot(N, expt_data_mat(1,:,1), 'r') % mean overfit, var = 0
hold on
plot(N, expt_data_mat(1,:,2), 'b')%mean overfit, var = .5
plot(N, expt_data_mat(1,:,3), 'y')%'mean overfit, var = 1
plot(N, expt_data_mat(1,:,4))%'mean overfit, var = 1.5
plot(N, expt_data_mat(1,:,5),'g')%'mean overfit, var = 2

hold off
xlabel('number of trainig data set')
ylabel('overfit measure')
legend('var = 0', 'var = 0.5', 'var = 1', 'var = 1.5', 'var = 2')
title('Testing overfit versus N and var (median)')
%% plot overfit vs N, fix Q_f, mean
figure(2)
plot(N, expt_data_mat2(1,:,1), 'r') % mean overfit, var = 0
hold on
plot(N, expt_data_mat2(1,:,2), 'b')%mean overfit, var = .5
plot(N, expt_data_mat2(1,:,3), 'y')%'mean overfit, var = 1
plot(N, expt_data_mat2(1,:,4))%'mean overfit, var = 1.5
plot(N, expt_data_mat2(1,:,5),'g')%'mean overfit, var = 2

hold off
xlabel('number of trainig data set')
ylabel('overfit measure')
legend('var = 0', 'var = 0.5', 'var = 1', 'var = 1.5', 'var = 2')
title('Testing overfit versus N and var (mean)')
%% plot overfit vs Q_f, fix N and var
figure(3)
plot(Q_f, expt_data_mat2(:,1,1),'r') % mean overfit, var = 0
xlabel('degree of target function')
ylabel('overfit measure')
title('Overfit measure mean versus Q_f with N = 120 and var = 0')
figure(4)
plot(Q_f, expt_data_mat(:,2,1)) % mean overfit, var = 0
xlabel('degree of target function')
ylabel('overfit measure')
title('Overfit measure median versus Q_f with N = 120 and var = 0')
%% plot overfit vs var with fix Qf = 5 and N = 120
figure(5)
expt_med = zeros(size(var));
expt_mean = zeros(size(var));

for n = 1:length(var)
    expt_med(n) = expt_data_mat(1,3,n);
    expt_mean(n) = expt_data_mat2(1,3,n);
end

plot(var, log(expt_med+1), 'r')
hold on
plot(var, log(expt_mean+1), 'g')
xlabel('stochastic noise variance')
title('Testing overfit versus stochastic noise variance with Q-f=5 and N =120')
ylabel('Overfit measure (log scale)')
legend('median overfit', 'mean overfit')
hold off