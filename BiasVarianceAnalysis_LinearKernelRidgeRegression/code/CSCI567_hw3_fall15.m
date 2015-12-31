% CSCI-567 HW#3
% 5 Programming - Bias/Variance Tradeoff

fprintf('\n\n');
disp('5 Programming - Bias/Variance Tradeoff');
% (a) 100 datasets with sample size 10
datasets = 100;
samples = 10;
fprintf('\na) Results for Samples Size = %d\n', samples);
plot_mse_and_report_bias_variance(datasets,samples);

% (b) 100 datasets with sample size 100
datasets = 100;
samples = 100;
fprintf('\nb) Results for Samples Size = %d\n', samples);
plot_mse_and_report_bias_variance(datasets,samples);

% (c) How model complexity and sample size affect the bias and variance
% Theory qyestion

% (d) h( x ) = w_0 + w_1.x + w_2.x^2 + \lambda( w_0^2 + w_1^2 + w_2^2 ) 
% for 100 samples per dataset estimate the bias and variance of h(x) 
% when \lambda is set to 0.01,0.1,1,10.
fprintf('\nd) h(x) with regularization ');
datasets = 100;
samples = 100;
lambda = [0.01,0.1,1,10];
report_bias_variance_with_regularization(datasets,samples,lambda);

% (Theory Question) Discuss how \lambda affects the bias and variance.


% 6 Programming - Regression
%
fprintf('\n\n');
disp('6 Programming - Regression');
allData = dlmread('space_ga.txt');
trainPercent = 80; % percent of train data out of allData
splitRuns = 10;
kFolds = 5; % K-fold CV

% -- Linear Ridge Regression -- 
fprintf('\n');
disp('-- Linear Ridge Regression --');
lambda = [0, 10^-4, 10^-3, 10^-2, 10^-1, 10^0, 10^1, 10^2, 10^3];
do_linear_ridge_regression(allData, trainPercent, splitRuns, kFolds, lambda);

% -- Kernel Ridge Regression --
fprintf('\n');
disp('-- Kernel Ridge Regression --');
lambda = [0+10^-9, 10^-4, 10^-3, 10^-2, 10^-1, 10^0, 10^1, 10^2, 10^3];

% % a) Linear kernel
% fprintf('\n');
% disp('a) Linear kernel');
% do_linear_kernel_regression(allData, trainPercent, splitRuns, kFolds, lambda);
% 
% % b) Polynomial kernel
% fprintf('\n');
% disp('b) Polynomial kernel');
% do_polynomial_kernel_regression(allData, trainPercent, splitRuns, kFolds, lambda);

% c) Gaussian RBF kernel
fprintf('\n');
disp('c) Gaussian RBF kernel');
do_gbrf_kernel_regression(allData, trainPercent, splitRuns, kFolds, lambda);

