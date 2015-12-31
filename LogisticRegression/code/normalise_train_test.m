function [trainX, testX] = normalise_train_test(trainX, testX)

[rowsTrain, columns] = size(trainX);
[rowsTest, ~] = size(testX);

for j=1:columns
    meanvTrain = zeros(rowsTrain,1);
    meanvTrain(:) = nanmean(trainX(:,j));
    meanvTest = zeros(rowsTest,1);
    meanvTest(:) = nanmean(trainX(:,j));
    
    stdvTrain = zeros(rowsTrain,1);
    stdvTrain(:) = nanstd(trainX(:,j));
    stdvTest = zeros(rowsTest,1);
    stdvTest(:) = nanstd(trainX(:,j));
    
    trainX(:,j) = trainX(:,j) - meanvTrain;
    testX(:,j) = testX(:,j) - meanvTest;
    
    trainX(:,j) = trainX(:,j)./stdvTrain;
    testX(:,j) = testX(:,j)./stdvTest;
end