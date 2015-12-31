function disp_accuracy_multiple_models(trainCell, trainSurv, testCell, testSurv, ageColNumber)

allCell = [trainCell;testCell];
trainX = get_combined_matrix_X(trainCell, allCell);
testX = get_combined_matrix_X(testCell, allCell);
[trainX, testX] = normalise_train_test(trainX, testX);

trainXAgeRemoved = trainX;
trainXAgeRemoved(:,ageColNumber) = [];
testXAgeRemoved = testX;
testXAgeRemoved(:,ageColNumber) = [];
coeffWithAge = glmfit(trainX, trainSurv, 'binomial');
coeffWithoutAge = glmfit(trainXAgeRemoved, trainSurv, 'binomial');

% accuracy on trainX
correctlyPredictedTrain = 0;
for j=1:length(trainX)
    if isnan(trainX(j,ageColNumber)) % nan value found
        yPred = glmval(coeffWithoutAge, trainXAgeRemoved(j,:), 'probit');
    else
        yPred = glmval(coeffWithAge, trainX(j,:), 'probit');
    end
    yClass = yPred >=0.5;
    if yClass == trainSurv(j)
        correctlyPredictedTrain = correctlyPredictedTrain + 1;
    end
end
trainAccuracy = correctlyPredictedTrain*100/length(trainX);
fprintf('Multiple Model- Train Accuracy = %f%%\n', trainAccuracy);

% accuracy on testX
correctlyPredictedTest = 0;
for j=1:length(testX)
    if isnan(testX(j,ageColNumber)) % nan value found
        yPred = glmval(coeffWithoutAge, testXAgeRemoved(j,:), 'probit');
    else
        yPred = glmval(coeffWithAge, testX(j,:), 'probit');
    end
    yClass = yPred >=0.5;
    if yClass == testSurv(j)
        correctlyPredictedTest = correctlyPredictedTest + 1;
    end
end
testAccuracy = correctlyPredictedTest*100/length(testX);
fprintf('Multiple Model- Test Accuracy = %f%%\n', testAccuracy);
