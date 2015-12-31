% 5 Programming



% 5.1 Density Estimation

% 5.1 (a)
load('hw1progde.mat');
% these 'reference' values are plotted along with all our curves to act as
% a reference so that comparison is easy.
[refEstimate, refXValues] = get_reference_estimate_from_all_data(x_tr,x_te);
hValues = [0.01 0.03 0.05 0.07 0.1];
plot_gaussian(x_tr, hValues, refEstimate, refXValues);
plot_epanechnikov(x_tr, hValues, refEstimate, refXValues);
plot_histogram(x_tr, hValues, refEstimate, refXValues);

% 5.1 (b)
hValues=0.001:0.0025:0.1; %plotting over many 'h' values to get smooth curve
[allSubsetData] = split_randomly_into_k_subsets(x_te, 19);
figure('name','Question 5.1(b)');
hold on;
plot_integrated_variance_gaussian(allSubsetData, hValues);
plot_integrated_variance_epanechnikov(allSubsetData, hValues);
plot_integrated_variance_histogram(allSubsetData, hValues);
title('Integrated Variance versus h for different estimators');
legend('Gaussian', 'Epanechnikov', 'Histogram');
xlabel('h');
ylabel('Integrated variance');
hold off;



% % 5.2 Classification


% 5.2 (a) Data Pre-processing
%Tic-Tac-Toe Dataset
%pre-process all hw1ttt_*.data files
[ttt_train_data, ttt_train_label] = ttt_data_preprocess('hw1ttt_train.data');
[ttt_valid_data, ttt_valid_label] = ttt_data_preprocess('hw1ttt_valid.data');
[ttt_test_data, ttt_test_label] = ttt_data_preprocess('hw1ttt_test.data');
%Nursery Dataset
%pre-process all hw1nursery_*.data files
[nursery_train_data, nursery_train_label] = nursery_data_preprocess('hw1nursery_train.data');
[nursery_valid_data, nursery_valid_label] = nursery_data_preprocess('hw1nursery_valid.data');
[nursery_test_data, nursery_test_label] = nursery_data_preprocess('hw1nursery_test.data');


% 5.2 (b) Implement Naive Bayes
% See 'naive_bayes.m' file


% 5.2 (c) Implement K-NN
% See 'knn_classify.m' file


% % 5.2 (d) Performance Comparison


% -- K-NN --
disp('== Accuracy Reports for 5.2 (d) ==');
disp('KNN');
disp('---');
kValues=1:2:15;
kLength=length(kValues);
train_data_accuracy = zeros(kLength, 1);
test_data_accuracy = zeros(kLength, 1);
valid_data_accuracy = zeros(kLength, 1);
K=zeros(kLength, 1);
arrayIndex=1;
for kValue=kValues
    [test_accu, ~] = knn_classify(ttt_train_data, ttt_train_label, ttt_test_data, ttt_test_label, kValue);
    [valid_accu, train_accu] = knn_classify(ttt_train_data, ttt_train_label, ttt_valid_data, ttt_valid_label, kValue);
    K(arrayIndex) = kValue;
    train_data_accuracy(arrayIndex) = train_accu;
    test_data_accuracy(arrayIndex) = test_accu;
    valid_data_accuracy(arrayIndex) = valid_accu;
    arrayIndex = arrayIndex + 1;
end
T = table(K, train_data_accuracy, test_data_accuracy, valid_data_accuracy, 'VariableNames',{'K' 'Training_Data_Accuracy' 'Test_Data_Accuracy' 'Validation_Data_Accuracy'});
disp(T);


% -- Decision Tree --
disp('Decision Tree');
disp('-------------');
splitCriterionGdi='gdi'; % 1
splitCriterionDeviance='deviance'; % 2
minLeafValues=1:1:10;
splitCriterionValues = 1:2;

totalCases = max(minLeafValues) * max(splitCriterionValues);
min_leaf_value = zeros(totalCases, 1);
split_criterion_value = {};
train_data_accuracy = zeros(totalCases, 1);
test_data_accuracy = zeros(totalCases, 1);
valid_data_accuracy = zeros(totalCases, 1);
arrayIndex=1;
for sc=splitCriterionValues
    if sc == 1
      SplitCriterion = splitCriterionGdi;
    else
      SplitCriterion = splitCriterionDeviance;
    end
    for minLeaf=minLeafValues
       
        split_criterion_value = [split_criterion_value SplitCriterion];
        min_leaf_value(arrayIndex)=minLeaf;
        
        %Training Decision Trees
        tree = ClassificationTree.fit(ttt_train_data, ttt_train_label, 'SplitCriterion', SplitCriterion, 'MinLeaf', minLeaf, 'Prune', 'off');

        %predicting for train/test/valid of ttt dataser
        ttt_predicted_labels = predict(tree, ttt_train_data);
        changesInLabels = ttt_predicted_labels - ttt_train_label;
        correctlyPredicted = length(find(changesInLabels==0));
        train_data_accuracy(arrayIndex) = (correctlyPredicted*100)/length(ttt_train_label);

        ttt_predicted_labels = predict(tree, ttt_test_data);
        changesInLabels = ttt_predicted_labels - ttt_test_label;
        correctlyPredicted = length(find(changesInLabels==0));
        test_data_accuracy(arrayIndex) = (correctlyPredicted*100)/length(ttt_test_label);

        ttt_predicted_labels = predict(tree, ttt_valid_data);
        changesInLabels = ttt_predicted_labels - ttt_valid_label;
        correctlyPredicted = length(find(changesInLabels==0));
        valid_data_accuracy(arrayIndex) = (correctlyPredicted*100)/length(ttt_valid_label);

        arrayIndex = arrayIndex + 1;
    end
end
T = table(split_criterion_value.', min_leaf_value, train_data_accuracy, test_data_accuracy, valid_data_accuracy, 'VariableNames',{'Split_Criterion' 'Min_Leaf' 'Train_Accuracy' 'Test_Accuracy' 'Valid_Accuracy'});
disp(T);


% -- Naive Bayes --
% Tic-Tac-Toe Endgame Dataset
disp('NAIVE BAYES');
disp('-----------');
[ttt_test_accu, ~] = naive_bayes(ttt_train_data, ttt_train_label, ttt_test_data, ttt_test_label);
[ttt_valid_accu, ttt_train_accu] = naive_bayes(ttt_train_data, ttt_train_label, ttt_valid_data, ttt_valid_label);
% Nursery Dataset
[nursery_test_accu, ~] = naive_bayes(nursery_train_data, nursery_train_label, nursery_test_data, nursery_test_label);
[nursery_valid_accu, nursery_train_accu] = naive_bayes(nursery_train_data, nursery_train_label, nursery_valid_data, nursery_valid_label);

dataset = {'TTT';'Nursery'};
train_data_accuracy = [ttt_train_accu nursery_train_accu];
test_data_accuracy = [ttt_test_accu nursery_test_accu];
valid_data_accuracy = [ttt_valid_accu nursery_valid_accu];
T = table(dataset, train_data_accuracy.', test_data_accuracy.', valid_data_accuracy.', 'VariableNames',{'dataset' 'Training_Data_Accuracy' 'Test_Data_Accuracy' 'Validation_Data_Accuracy'});
disp(T);



% 5.2 (e)
boundaryData = load('hw1boundary.mat');%boundaryData.features, boundaryData.labels
N = length(boundaryData.features);
[boundaryData.featuresX, xMean, xSD] = normalise_vector(boundaryData.features(:,1));
[boundaryData.featuresY, yMean, ySD] = normalise_vector(boundaryData.features(:,2));

xAxis=.01:.01:1;
yAxis=.01:.01:1;
totalPoints = length(x)*length(y);
kValues=[1 5 15 25];

figure('Name', 'Question 5.2(e), Plots for Different values of K')
for k=kValues
    xValues=zeros(totalPoints,1);
    xValues(:)=-1;
    yValues=zeros(totalPoints,1);
    yValues(:)=-1;
    groupings=zeros(totalPoints,1);
    groupings(:)=inf;
    index=1;
    for x=xAxis
        for y=yAxis
            %predict labels for each (x,y) pair via K-NN, and store in groupings
            xValues(index)=x;% for plotting
            yValues(index)=y;
            xn=(x-xMean)/xSD;%normalised for calculating distance for KNN
            yn=(y-yMean)/ySD;
            valueArray = [xn yn];

            %
            distanceVector = zeros(N,1); % distances from each N(boundaryData.features)
            distanceVector(:) = inf;
            for ii=1:N %iterate over all N
                trainingArray = [boundaryData.featuresX(ii) boundaryData.featuresY(ii)];
                distanceVector(ii) = norm(trainingArray - valueArray);
            end
            [~,si] = sort(distanceVector);%assending sort and get first K from 'si'- sort index
            topKIndexes = si(1:k);
            %find labels for these top K indexes, and select the label which
            %occurs the most (highest frequency)
            classifiedLabel = mode(boundaryData.labels(topKIndexes)); % here mode works because there can be only 2 classes, and so with odd K we have no ties.
            %
            groupings(index)=classifiedLabel;
            index=index+1;
        end
    end
    subplot(length(kValues)/2,length(kValues)/2,find(kValues==k));
    gscatter(xValues, yValues, groupings);
    title(['K = ' num2str(k)]);
end