function [trainX,trainY,testX,testY] = random_divide_train_test(allData, trainPercent)
% trainPercent - the amount of data which will be train, rest will be test

lengthAllData = size(allData,1);
columnsAllData = size(allData,2);
randRows = randperm(lengthAllData);
trainRows = round(trainPercent*lengthAllData/100);
testRows = lengthAllData - trainRows;

trainX = zeros(trainRows,columnsAllData -1);
trainY = zeros(trainRows,1);
testX = zeros(testRows,columnsAllData -1);
testY = zeros(testRows,1);
%distribute random rows into train and test
for j=1:lengthAllData
    randomRow = randRows(j);
    if j<= trainRows
        trainX(j,:) = allData(randomRow,2:columnsAllData);
        trainY(j,:) = allData(randomRow,1);
    else
        testX(j-trainRows,:) = allData(randomRow,2:columnsAllData);
        testY(j-trainRows,:) = allData(randomRow,1);
    end    
end