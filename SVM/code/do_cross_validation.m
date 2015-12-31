function bestC = do_cross_validation(newTrFeat, yTr)

C = [4^-6, 4^-5, 4^-4, 4^-3, 4^-2, 4^-1, 4^-0, 4^1, 4^2];
accuracies = zeros(length(C),3);
trainTime = zeros(length(C),3);
for i = 1:length(C)
    xTrSplit = newTrFeat(667:2000,:);
    yTrSplit = yTr(667:2000,:);
    xTeSplit = newTrFeat(1:666,:);
    yTeSplit = yTr(1:666,:);
    [accuracies(i,1),trainTime(i,1)] = own_linear(xTrSplit, yTrSplit, xTeSplit, yTeSplit, C(i));
    
    xTrSplit = [newTrFeat(1:666,:) ; newTrFeat(1334:2000,:)];
    yTrSplit = [yTr(1:666,:) ; yTr(1334:2000,:)];
    xTeSplit = newTrFeat(667:1333,:);
    yTeSplit = yTr(667:1333,:);
    [accuracies(i,2),trainTime(i,2)] = own_linear(xTrSplit, yTrSplit, xTeSplit, yTeSplit, C(i));
    
    xTrSplit = newTrFeat(1:1333,:);
    yTrSplit = yTr(1:1333,:);
    xTeSplit = newTrFeat(1334:2000,:);
    yTeSplit = yTr(1334:2000,:);
    [accuracies(i,3),trainTime(i,3)] = own_linear(xTrSplit, yTrSplit, xTeSplit, yTeSplit, C(i));
end
meanAccuracy = mean(accuracies,2);
meanTrainTime = mean(trainTime,2);


for i = 1:length(C)
    fprintf('\n For C = %f, Average Accuracy = %f and Average Train Time = %f', C(i), meanAccuracy(i), meanTrainTime(i));
end
fprintf('\n');

bestC = C(meanAccuracy == max(meanAccuracy));