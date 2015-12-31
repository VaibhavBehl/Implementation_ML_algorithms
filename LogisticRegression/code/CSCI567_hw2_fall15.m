% 4 Programming - Logistic Regression



% (a) Load Data
% raw is in cell format (both numbers and strings)
[~, ~, raw] = xlsread('titanic3.csv');
% trainCell and testCell have columns in following order(survived removed)-
% pclass(1), name(2), sex(3), age(4), sibsp(5), parch(6), ticket(7),
% fare(8), cabin(9), embarked(10), boat(11), body(12), home.dest(13)
disp(' ');
disp('-- a) Load Data --');
[trainCell, trainSurv, testCell, testSurv] = load_data(raw);

% (b) Monotonic Relationship
disp(' ');
disp('-- b) Monotonic Relationship --');
relationship_plots(trainCell, trainSurv);
disp('see plot of: Probability of Survival vs Feature Class');

% (c) Mutual Information
disp(' ');
disp('-- c) Mutual Information --');
disp_mutual_information(trainSurv, trainCell);

% (d) Missing Values
disp(' ');
disp('-- d) Missing Values --');
% X matrices for both the training and test data from columns 
% {sex, pclass, fare, embarked, parch, sibsp, age}
ageColNumber = 9; % column with NAN values
disp_accuracy_multiple_models(trainCell, trainSurv, testCell, testSurv, ageColNumber);
disp_accuracy_substituting_values(trainCell, trainSurv, testCell, testSurv, ageColNumber);

% % (e) Basis Expansion - we get approx ~832 columns in X matrices after this
disp('-- e) Basis Expansion --');
[trainX, testX] = do_basis_expansion(trainCell, testCell);
fprintf('\nThe number of columns after doing Basis Expansion is: %d \n', size(trainX,2));

% (f) Sequential Feature Selection
warning('off');
disp('-- f) Sequential Feature Selection --');
iterations = 10;
[currentFeatureIndexArray, trainAccuracyArray, testAccuracyArray] = do_sequential_feature_selection(trainX, trainSurv, testX, testSurv, iterations);
xaxis = 1:10;
figure;
hold on;
plot(xaxis, trainAccuracyArray, 'b-o');
plot(xaxis, testAccuracyArray, 'r-x');
disp('see plot of: Accuracy vs Number of Forward-Selected Features');
title('Accuracy vs Number of Forward-Selected Features');
legend('train accuracy', 'test accuracy');
ylabel('Accuracy');
xlabel('Number of features');
hold off;
warning('on');

% (g) Batch Gradient Descent
disp(' ');
disp('-- g) Batch Gradient Descent --');
do_batch_gradient(trainX, trainSurv, testX, testSurv, currentFeatureIndexArray);

% (h) Newtons Method
disp(' ');
disp('-- h) Newton''s Method --');
do_newtonds_method(trainX, trainSurv, testX, testSurv, currentFeatureIndexArray);