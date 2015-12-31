function [currentFeatureIndexArray, trainAccuracyArray, testAccuracyArray] = do_sequential_feature_selection(trainX, trainSurv, testX, testSurv, iterations)

[~, columns] = size(trainX);

currentFeatureIndexArray = [];
trainAccuracyArray = zeros(10,1);
testAccuracyArray = zeros(10,1);

for j=1:iterations % outer loop to select 10 best features 
    fprintf('Inside Iteration %d\n', j);
    bestFeatureIndex = 0;
    bestFeatureTrainAccuracy = 0; %feature selection criteria ->max train accuracy
    bestFeatureTestAccuracy = 0;
    for k = 1:columns % inner loop to iterate over all columns (except those already selected), and run glmfit/glmval and predict training accuracy
        if not(any(currentFeatureIndexArray == k)) % don't if column already selected
            trainXSub = trainX(:, [currentFeatureIndexArray k]);
            testXSub = testX(:, [currentFeatureIndexArray k]);
            [trainAccu, testAccu] = find_train_test_accuracy_glm(trainXSub, trainSurv, testXSub, testSurv);
            if trainAccu > bestFeatureTrainAccuracy
                bestFeatureIndex = k;
                bestFeatureTrainAccuracy = trainAccu;
                bestFeatureTestAccuracy = testAccu;
            end
        end
    end
    currentFeatureIndexArray = [currentFeatureIndexArray bestFeatureIndex];
    trainAccuracyArray(j) = bestFeatureTrainAccuracy;
    testAccuracyArray(j) = bestFeatureTestAccuracy;
end