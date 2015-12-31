function do_gbrf_kernel_regression(allData, trainPercent, splitRuns, kFolds, lambda)

err = zeros(1,splitRuns);
for split=1:splitRuns
    [trainX,trainY,testX,testY] = random_divide_train_test(allData,trainPercent);
    [trainX, testX] = normalise_train_test(trainX,testX);

    trainRows = size(trainX,1);
     
    cvIndices = crossvalind('Kfold', trainRows, kFolds); % indices with K=1,2,3,4,5 values

    bestMeanMse = inf;
    varianceValues = [0.125, 0.25, 0.5, 1, 2, 4, 8];
    
    for variance=varianceValues
        for lambdaValue = lambda
            sumMse = 0;
            for j=1:kFolds % for all k values, j will be the test set
                crossTrainX = trainX(cvIndices ~= j,:);
                crossTrainY = trainY(cvIndices ~= j);
                crossTestX = trainX(cvIndices == j,:);
                crossTestY = trainY(cvIndices == j);
                mse = kernel_GRBF_find_test_error(crossTrainX,crossTrainY,crossTestX,crossTestY,lambdaValue,variance);
                sumMse = sumMse + mse;
            end
            meanMse = sumMse/kFolds;
            if meanMse < bestMeanMse
                bestMeanMse = meanMse;
                bestLambda = lambdaValue;
                bestVariance = variance;
            end
        end
    end
    fprintf('For Random Split: %d - Optimal Lambda value = %0.4f, Variance value = %0.3f \n', split, bestLambda, bestVariance);
    
    % calculating average test error using this 'bestLambda' value
    err(split) = kernel_GRBF_find_test_error(trainX,trainY,testX,testY,bestLambda,bestVariance);
end
fprintf('Average Test Error over all %d random splits = %f\n', splitRuns, mean(err));