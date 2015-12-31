function mse = linear_regression_find_test_error(trainX,trainY,testX,testY,lambdaValue)
% all X matrices in input are without 'ones'

N = size(trainX,1);
XTr = [ones(N,1) trainX];
M = size(XTr,2);
YTr = trainY;

w = (XTr'*XTr + lambdaValue.*eye(M))\XTr'*YTr;

% now using testX to make predictions and compare to testY and compute MSE

NTest = size(testX,1);
XTe = [ones(NTest,1) testX];
MTest = size(XTe,2);

%calculate testYPred
sse = 0;
for j=1:NTest
	yPredValue = 0;
    for featIndex=1:MTest
        yPredValue = yPredValue + w(featIndex)*XTe(j,featIndex);
    end
    sse = sse + (yPredValue-testY(j)).^2;
end
mse = sse/NTest;