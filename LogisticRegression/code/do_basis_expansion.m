function [trainX, testX] = do_basis_expansion(trainCell, testCell)
% this function will build a new X matrix for both train and test according
% to the steps mentioned in the question.

% starting from X matrix with NAN present in AGE column and not normalised
% X[dvSex(1) dvPclass(2,3) fare(4) dvEmbarked(5,6) parch(7) sibsp(8) age(9)]
allCell = [trainCell;testCell]; % only for keeping encoding consistent
trainX = get_combined_matrix_X(trainCell, allCell);
testX = get_combined_matrix_X(testCell, allCell);

% Append columns with the square-root of numeric values of(pclass, age, sibsp, parch, fare)
pClassTrain = cell2mat(trainCell(:,1));
ageTrain = trainX(:,9);
sibspTrain = trainX(:,8);
parchTrain = trainX(:,7);
fareTrain = trainX(:,4);
sqrtTrainX = [sqrt(pClassTrain) sqrt(ageTrain) sqrt(sibspTrain) sqrt(parchTrain) sqrt(fareTrain)];
pClassTest = cell2mat(testCell(:,1));
ageTest = testX(:,9);
sibspTest = testX(:,8);
parchTest = testX(:,7);
fareTest = testX(:,4);
sqrtTestX = [sqrt(pClassTest) sqrt(ageTest) sqrt(sibspTest) sqrt(parchTest) sqrt(fareTest)];
trainX = [trainX sqrtTrainX];
testX = [testX sqrtTestX];

% Append 5 descritised numeric variables as dummy_encoded_variables(pclass, age, sibsp, parch, fare)
dvPclassTrain = get_dummy_encoding_drop_one(cell2mat(trainCell(:,1)), cell2mat(allCell(:,1)), false);
ageTrain = cell2mat(trainCell(:,4));
ageTrainDescritizationPts = get_descritization_Points(ageTrain);
ageTrainDescriterized = apply_descritization(ageTrainDescritizationPts, ageTrain);
fareTrain = trainX(:,4);
fareTrainDescritizationPts = get_descritization_Points(fareTrain);
fareTrainDescriterized = apply_descritization(fareTrainDescritizationPts, fareTrain);
dvParchTrain = get_dummy_encoding_drop_one(cell2mat(trainCell(:,6)), cell2mat(allCell(:,6)), false);
dvSibspTrain = get_dummy_encoding_drop_one(cell2mat(trainCell(:,5)), cell2mat(allCell(:,5)), false);

dvPclassTest = get_dummy_encoding_drop_one(cell2mat(testCell(:,1)), cell2mat(allCell(:,1)), false);
ageTest = cell2mat(testCell(:,4));
ageTestDescriterized = apply_descritization(ageTrainDescritizationPts, ageTest);
fareTest = testX(:,4);
fareTestDescriterized = apply_descritization(fareTrainDescritizationPts, fareTest);
dvParchTest = get_dummy_encoding_drop_one(cell2mat(testCell(:,6)), cell2mat(allCell(:,6)), false);
dvSibspTest = get_dummy_encoding_drop_one(cell2mat(testCell(:,5)), cell2mat(allCell(:,5)), false);

allAgeDescriterized = [ageTrainDescriterized; ageTestDescriterized];
dvAgeTrainDescriterized = get_dummy_encoding_drop_one(ageTrainDescriterized, allAgeDescriterized, true);
dvAgeTestDescriterized = get_dummy_encoding_drop_one(ageTestDescriterized, allAgeDescriterized, true);
allFareDescriterized = [fareTrainDescriterized; fareTestDescriterized];
dvFareTrainDescriterized = get_dummy_encoding_drop_one(fareTrainDescriterized, allFareDescriterized, false);
dvFareTestDescriterized = get_dummy_encoding_drop_one(fareTestDescriterized, allFareDescriterized, false);

dummyEncodedNumericTrain = [dvPclassTrain dvAgeTrainDescriterized dvSibspTrain dvParchTrain dvFareTrainDescriterized];
dummyEncodedNumericTest = [dvPclassTest dvAgeTestDescriterized dvSibspTest dvParchTest dvFareTestDescriterized];

trainX = [trainX dummyEncodedNumericTrain];
testX = [testX dummyEncodedNumericTest];

% Append interaction variables
trainInteractionMat = get_interaction_matrix(trainX);
testInteractionMat = get_interaction_matrix(testX);
trainX = [trainX trainInteractionMat];
testX = [testX testInteractionMat];

%remove columns having only one non-distinct values
[trainX, onlySingleDistinct] = remove_non_distinct_columns(trainX);
testX(:, onlySingleDistinct) = [];

%finally normalizing
[trainX, testX] = normalise_train_test(trainX, testX);