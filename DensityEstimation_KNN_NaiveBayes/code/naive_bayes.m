function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)
% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1

    sizeTrainData = size(train_data);
    N = sizeTrainData(1);% number of samples in training data
    D = sizeTrainData(2);% number of features
    sizeNewData = size(new_data);
    M = sizeNewData(1);% number of samples in new data

    trainClasses = unique(train_label);% array of unique classes/labels. eg (1 2 3 4 5)
    featureTypes = unique(train_data(:)); % should be (0 1) since binary
    % 3D matrix to store data needed to compute P(C|new sample)
    nbProbData = zeros(length(trainClasses), D, length(featureTypes));
    nbProbData(:)=-1;
    nbProbOfClasses = zeros(length(trainClasses), 1);% for P(C1), P(C2),....
    nbProbOfClasses(:)=-1;

    %BUILDING DATA For NAIVE BAYES CLASSIFICATION
    for class=transpose(trainClasses) %iterate all possible classes. eg (1 2 3 4 5)
        nbProbOfClasses(class) = length(find(train_label==class))/length(train_label);
        indexesForClass = find(train_label == class);
        for ii=1:D %iterate all features
            trainDataForClassAndFeature = train_data(indexesForClass, ii);
            totalCountForClassAndFeature = length(trainDataForClassAndFeature); %to be used in probability formula
            for jj=transpose(featureTypes) %iterate feature types. eg (0 1)
                totalCountForJJ = length(find(trainDataForClassAndFeature == jj));
                if totalCountForJJ == 0
                    totalCountForJJ = 0.1;
                end
                nbProbData(class, ii, find(featureTypes==jj))= totalCountForJJ/totalCountForClassAndFeature;
            end
        end
    end

    %FINDING ACCURACY On NEW DATA
    train_accu = find_accuracy(train_data, train_label);
    new_accu = find_accuracy(new_data, new_label);
    


    function [accu] = find_accuracy(data, label)

        correctlyClassified=0; % and also refer to variable 'N' above for total.

        for indexData=1:length(data) %iterate all samples
            sample = data(indexData,:);%will classify this sample
            sampleOrigClass = label(indexData);% actual class
            %for each sample, find P() for all classes and take the MAX value
            maxProb=-1;
            maxProbClass=-1;
            for tc=transpose(trainClasses)
                probProduct = nbProbOfClasses(tc);
                for k=1:D %iterate over all features for given 'sample'
                    multiplier = nbProbData(tc, k, find(featureTypes==sample(k)));
%                     if multiplier == 0
%                         multiplier = 0.1;% 0
%                     end
                    probProduct=probProduct*multiplier;
                end
                if probProduct>maxProb
                    maxProb = probProduct;
                    maxProbClass = tc;
                end
            end
            %compare maxProbClass and sampleOrigClass
            if maxProbClass == sampleOrigClass
                correctlyClassified = correctlyClassified + 1;
            end
        end

        accu = correctlyClassified*100/length(data);
    end
end
