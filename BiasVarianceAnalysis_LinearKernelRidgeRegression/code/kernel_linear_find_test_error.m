function mse = kernel_linear_find_test_error(trainX,trainY,testX,testY,lambdaValue)

N = size(trainX,1);
XTr = [ones(N,1) trainX];
YTr = trainY;


% x_i/x_j will be the transpose(i-th row if X matrix)
% and K(i,j) = k(x_i,x_j) = x_i^T * x_j, which can be written as K=X*X'
K = XTr*XTr';

% now making predictions and compare to testY and compute MSE

NTest = size(testX,1);
XTe = [ones(NTest,1) testX];

kxmat = XTr*XTe';
%calculate yPred
yPred = YTr' * ((K + lambdaValue.*eye(N))\kxmat);
sse = norm(yPred' - testY)^2;
mse = sse/NTest;