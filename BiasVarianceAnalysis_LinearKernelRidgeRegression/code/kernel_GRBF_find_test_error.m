function mse = kernel_GRBF_find_test_error(trainX,trainY,testX,testY,lambdaValue,variance)

N = size(trainX,1);
XTr = [ones(N,1) trainX];
YTr = trainY;

% x_i/x_j will be the transpose(i-th row if X matrix)
% and K(i,j) = k(x_i,x_j) = x_i^T * x_j, which can be written as K=X*X'
K = exp ( (pdist2(XTr,XTr).^2)./(-(variance)) );

% now making predictions and compare to testY and compute MSE
NTest = size(testX,1);
XTe = [ones(NTest,1) testX];

%calculate testYPred
% sse = 0;
% for j=1:NTest    
%     kx = zeros(N,1); % for every prediction
%     for k=1:N
%         kx(k) = ((XTr(k)*XTe(j)')+a).^b;
%     end
% 	yPredValue = YTr' * ((K + lambdaValue.*eye(N))\kx);
%     sse = sse + (yPredValue-testY(j)).^2;
% end
kxmat = exp ( (pdist2(XTr,XTe).^2)./(-(variance)) );
%calculate yPred
yPred = YTr' * ((K + lambdaValue.*eye(N))\kxmat);
sse = norm(yPred' - testY)^2;
mse = sse/NTest;