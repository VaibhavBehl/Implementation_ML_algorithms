% scripts to use best kernel found through CV, and use it to predict test
% set accuracy.

train = load('phishing-train.mat');
test = load('phishing-test.mat');

newTrFeat = transform_features(train.features);
yTr = double(train.label');
newTeFeat = transform_features(test.features);
yTe = double(test.label');

% optimal Kernel = RBF
% Optimal C = 64, gamma = 0.0625
rbfSvmModel = svmtrain(yTr, newTrFeat, '-t 2 -g 0.0625 -c 64 -q');
[~, accuracy, ~] = svmpredict(yTe, newTeFeat, rbfSvmModel, '');
