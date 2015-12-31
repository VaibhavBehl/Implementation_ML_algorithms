function [trainAccu, testAccu] = find_train_test_accuracy_glm(trainXSub, trainSurv, testXSub, testSurv)

%calculating train accuracy
trainCoeff = glmfit(trainXSub, trainSurv, 'binomial');
yPred = glmval(trainCoeff, trainXSub, 'probit');
yPredClass = yPred>=0.5;
%compare yPredClass with trainSurv to get accuracy
trainAccu = sum(not(xor(trainSurv,yPredClass)))*100/length(trainSurv);

%calculating test accuracy
yPred = glmval(trainCoeff, testXSub, 'probit');
yPredClass = yPred>=0.5;
%compare yPredClass with trainSurv to get accuracy
testAccu = sum(not(xor(testSurv, yPredClass)))*100/length(trainSurv);
