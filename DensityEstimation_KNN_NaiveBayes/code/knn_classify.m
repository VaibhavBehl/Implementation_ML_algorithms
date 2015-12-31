function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, K)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  K: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1

    normal_train_data = normalise_matrix(train_data);
    normal_new_data = normalise_matrix(new_data);

    N = length(normal_train_data);% number of samples in training data
    M = length(normal_new_data);% number of samples in new data
    
    %Calculating Training Accuracy (leave one out)
    correctlyClassifiedTrain = 0;
    for ii=1:N
       selectedIndex = ii;
       selectedIndexOrigLabel = train_label(selectedIndex);
       distanceVector = zeros(N,1);
       distanceVector(:) = inf;
       for jj=1:N %iterate over rest for ii
           if jj~=ii % excluding ii
               distanceVector(jj) = norm(normal_train_data(ii,:) - normal_train_data(jj,:));
           end
       end
       [~,si] = sort(distanceVector);%assending sort and get first K from 'si'- sort index
       topKIndexes = si(1:K);
       %find labels for these top K indexes, and select the label which
       %occurs the most (highest frequency)
       selectedIndexClassifiedLabel = mode(train_label(topKIndexes)); % here mode works because there can be only 2 classes, and so with odd K we have no ties.
       if selectedIndexClassifiedLabel == selectedIndexOrigLabel
           correctlyClassifiedTrain = correctlyClassifiedTrain + 1;
       end
    end
    train_accu = correctlyClassifiedTrain*100/N;
    
    %Calculating New Data Accuracy (with help of training data)
    correctlyClassifiedNew = 0;
    for ii=1:M %iterate all NEW data
       selectedIndex = ii;
       selectedIndexOrigLabel = new_label(selectedIndex);
       distanceVector = zeros(N,1); % distances from each N(training dataset)
       distanceVector(:) = inf;
       for jj=1:N %iterate over all N(training dataset)
            distanceVector(jj) = norm(normal_new_data(ii,:) - normal_train_data(jj,:));
       end
       [~,si] = sort(distanceVector);%assending sort and get first K from 'si'- sort index
       topKIndexes = si(1:K);
       %find labels for these top K indexes, and select the label which
       %occurs the most (highest frequency)
       selectedIndexClassifiedLabel = mode(train_label(topKIndexes)); % here mode works because there can be only 2 classes, and so with odd K we have no ties.
       if selectedIndexClassifiedLabel == selectedIndexOrigLabel
           correctlyClassifiedNew = correctlyClassifiedNew + 1;
       end
    end
    new_accu = correctlyClassifiedNew*100/M;
end