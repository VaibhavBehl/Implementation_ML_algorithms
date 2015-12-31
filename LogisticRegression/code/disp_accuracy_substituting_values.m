function disp_accuracy_substituting_values(trainCell, trainSurv, testCell, testSurv, ageColNumber)

allCell = [trainCell;testCell];
trainX = get_combined_matrix_X(trainCell, allCell);
ageColMean = nanmean(trainX(:,ageColNumber));
ageColNanRows = isnan(trainX(:,ageColNumber));
trainX(ageColNanRows, ageColNumber) = ageColMean; % replacing nan-rows with mean value

testX = get_combined_matrix_X(testCell, allCell);
ageColNanRows = isnan(testX(:,ageColNumber));
testX(ageColNanRows, ageColNumber) = ageColMean; 

[trainX, testX] = normalise_train_test(trainX, testX);
coeffSubstitute = glmfit(trainX, trainSurv, 'binomial');

% accuracy on trainX
correctlyPredictedTrain = 0;
for j=1:length(trainX)
    yhat = glmval(coeffSubstitute, trainX(j,:), 'probit');
    yClass = yhat >=0.5;
    if yClass == trainSurv(j)
        correctlyPredictedTrain = correctlyPredictedTrain + 1;
    end
end
trainAccuracy = correctlyPredictedTrain*100/length(trainX);
fprintf('Substituting- Train Accuracy = %f%%\n', trainAccuracy);
% accuracy on testX
correctlyPredictedTest = 0;
for j=1:length(testX)
    yhat = glmval(coeffSubstitute, testX(j,:), 'probit');
    yClass = yhat >=0.5;
    if yClass == testSurv(j)
        correctlyPredictedTest = correctlyPredictedTest + 1;
    end
end
testAccuracy = correctlyPredictedTest*100/length(testX);
fprintf('Substituting- Test Accuracy = %f%%\n', testAccuracy);
