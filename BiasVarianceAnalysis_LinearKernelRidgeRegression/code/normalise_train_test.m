function [trainX, testX] = normalise_train_test(trainX, testX)

[rowsTrain, columns] = size(trainX);
[rowsTest, ~] = size(testX);

for j=1:columns
    meanvTrain = zeros(rowsTrain,1);
    meanvTrain(:) = mean(trainX(:,j));
    meanvTest = zeros(rowsTest,1);
    meanvTest(:) = mean(trainX(:,j));
    
    stdvTrain = zeros(rowsTrain,1);
    stdvTrain(:) = std(trainX(:,j));
    stdvTest = zeros(rowsTest,1);
    stdvTest(:) = std(trainX(:,j));
    
    trainX(:,j) = trainX(:,j) - meanvTrain;
    testX(:,j) = testX(:,j) - meanvTest;
    
    trainX(:,j) = trainX(:,j)./stdvTrain;
    testX(:,j) = testX(:,j)./stdvTest;
end