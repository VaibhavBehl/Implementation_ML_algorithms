function [trainAccu, testAccu] = calculate_tr_te_accuracy(trX, trainSurv, teX, testSurv, theta)
% returns train and  test accuracy for a set of theta values

sigmaFun = inline('1.0 ./ (1.0 + exp(-z))');
hyTheta = sigmaFun(trX*theta');
hyThetaClass = hyTheta>=0.5;
trainAccu = sum(not(xor(hyThetaClass, trainSurv)))*100/length(trainSurv);
hy_test = sigmaFun(teX*theta');
hyThetaClass = hy_test>=0.5;
testAccu = sum(not(xor(hyThetaClass, testSurv)))*100/length(testSurv);
