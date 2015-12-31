% CSCI-567 HW#4
% 3 Programming
fprintf('\n\n');
disp('3 Programming');

% 3.1 Data preprocessing
fprintf('\n\n');
disp('3.1 Data preprocessing');
train = load('phishing-train.mat');
test = load('phishing-test.mat');

newTrFeat = transform_features(train.features);
yTr = double(train.label');
newTeFeat = transform_features(test.features);
yTe = double(test.label');

% 3.3 Cross validation for linear SVM
fprintf('\n 3.3 Cross validation for linear SVM');

fprintf('\n 3.3 (a) Cross validation result');
bestC = do_cross_validation(newTrFeat, yTr);
fprintf('\n');

fprintf('\n 3.3 (b) Best C is %f', bestC);
fprintf('\n');

[accuracy, ~] = own_linear(newTrFeat, yTr, newTeFeat, yTe, bestC);
fprintf('\n 3.3 (c) Accuracy on Test set using the Best C is %f', accuracy);
fprintf('\n');


% 3.4 Use linear SVM in LIBSVM
fprintf('\n 3.4 Use linear SVM in LIBSVM');
fprintf('\n');
C = [4^-6, 4^-5, 4^-4, 4^-3, 4^-2, 4^-1, 4^-0, 4^1, 4^2];
lsvmAccuracies = zeros(length(C),1);
trainTime = zeros(length(C),1);
for i = 1:length(C)
    tic;
    lsvmAccuracies(i) = svmtrain(yTr, newTrFeat, ['-t 0 -c ', num2str(C(i)), ' -v 3 -q']);
    trainTime(i) = toc/3;
end
% display accuracy and train time
for i = 1:length(C)
    fprintf('\n For C = %f, 3-fold Accuracy = %f and Train Time = %f', C(i), lsvmAccuracies(i), trainTime(i));
end
maxLsvmAcc = max(lsvmAccuracies);
fprintf('\n ***************** Best accuracy for linear SVM with LIBSVM = %s, for C = %s \n', mat2str(maxLsvmAcc), mat2str(C(lsvmAccuracies == maxLsvmAcc)));

% 3.5 Use kernel SVM in LIBSVM
% (a) Polynomial Kernel
fprintf('\n 3.5 Use kernel SVM in LIBSVM');
fprintf('\n (a) Polynomial Kernel');
fprintf('\n');

C = [4^-3, 4^-2, 4^-1, 4^-0, 4^1, 4^2, 4^3, 4^4, 4^5, 4^6, 4^7];
degree = [1, 2, 3];
pksvmAccuracies = zeros(length(C),length(degree));
trainTime = zeros(length(C),length(degree));
for i = 1:length(C)
    for j = 1:length(degree)
        tic;
        pksvmAccuracies(i,j) = svmtrain(yTr, newTrFeat, ['-t 1 -d ', num2str(degree(j)) ,' -c ', num2str(C(i)), ' -v 3 -q']);
        trainTime(i,j) = toc;
    end
end
for i = 1:length(C)
    for j = 1:length(degree)
        fprintf('\n For C = %f and Degree = %d, 3-fold Accuracy = %f and Average Train Time = %f', C(i), degree(j), pksvmAccuracies(i,j), trainTime(i,j));
    end
end
maxPksvmAcc = max(max(pksvmAccuracies));
[pksI,pksJ] = find(pksvmAccuracies == maxPksvmAcc);
fprintf('\n ***************** Best accuracy for Polynomial Kernel SVM with LIBSVM = %s, for C = %s, Degree = %s \n', mat2str(maxPksvmAcc), mat2str(C(pksI)), mat2str(degree(pksJ)));


% (b) RBF Kernel
fprintf('\n (b) RBF Kernel');
fprintf('\n');
C = [4^-3, 4^-2, 4^-1, 4^-0, 4^1, 4^2, 4^3, 4^4, 4^5, 4^6, 4^7];
gamma = [4^-7,4^-6,4^-5,4^-4,4^-3, 4^-2, 4^-1];
rbfsvmAccuracies = zeros(length(C),length(degree));
for i = 1:length(C)
    for j = 1:length(gamma)
        tic;
        rbfsvmAccuracies(i,j) = svmtrain(yTr, newTrFeat, ['-t 2 -g ', num2str(gamma(j)) ,' -c ', num2str(C(i)), ' -v 3 -q']);
        trainTime(i,j) = toc;
    end
end
for i = 1:length(C)
    for j = 1:length(gamma)
        fprintf('\n For C = %f and gamma = %d, 3-fold Accuracy = %f and Train Time = %f', C(i), gamma(j), rbfsvmAccuracies(i,j), trainTime(i,j));
    end
end
maxRbfsvmAcc = max(max(rbfsvmAccuracies));
[rbfI,rbfJ] = find(rbfsvmAccuracies == maxRbfsvmAcc);
fprintf('\n ***************** Best accuracy for RBF Kernel SVM with LIBSVM = %s, for C = %s, gamma = %s \n', mat2str(maxRbfsvmAcc), mat2str(C(rbfI)), mat2str(gamma(rbfJ)));


