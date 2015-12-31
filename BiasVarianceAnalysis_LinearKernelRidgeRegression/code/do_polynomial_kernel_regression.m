function do_polynomial_kernel_regression(allData, trainPercent, splitRuns, kFolds, lambda)

%randomly reducing allData by a 6th to increase running time
cvidx = crossvalind('Kfold', length(allData), 6);
allData = allData(cvidx == 1,:);

err = zeros(1,splitRuns);
for split=1:splitRuns
    [trainX,trainY,testX,testY] = random_divide_train_test(allData,trainPercent);
    [trainX, testX] = normalise_train_test(trainX,testX);

    trainRows = size(trainX,1);
     
    cvIndices = crossvalind('Kfold', trainRows, kFolds); % indices with K=1,2,3,4,5 values
    bestMeanMse = inf;
    aValues = [-1, -0.5, 0, 0.5, 1];
    bValues = [1, 2, 3, 4];
    
    for a=aValues
        for b=bValues
            for lambdaValue = lambda
                sumMse = 0;
                for j=1:kFolds % for all k values, j will be the test set
                    crossTrainX = trainX(cvIndices ~= j,:);
                    crossTrainY = trainY(cvIndices ~= j);
                    crossTestX = trainX(cvIndices == j,:);
                    crossTestY = trainY(cvIndices == j);
                    mse = kernel_polynomial_find_test_error(crossTrainX,crossTrainY,crossTestX,crossTestY,lambdaValue,a,b);
                    sumMse = sumMse + mse;
                end
                meanMse = sumMse/kFolds;
                if meanMse < bestMeanMse
                    bestMeanMse = meanMse;
                    bestLambda = lambdaValue;
                    bestA = a;
                    bestB = b;
                end
            end
        end
    end
    fprintf('For Random Split: %d - Optimal Lambda value = %0.4f, a value = %0.1f, b value = %d\n', split, bestLambda, bestA, bestB);
    
    % calculating average test error using this 'bestLambda' value
    err(split) = kernel_polynomial_find_test_error(trainX,trainY,testX,testY,bestLambda,bestA,bestB);
end
fprintf('Average Test Error over all %d random splits = %f\n', splitRuns, mean(err));
