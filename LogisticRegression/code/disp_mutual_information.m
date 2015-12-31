function disp_mutual_information(trainSurv, trainCell)

    featureNameArr = {};
    mutualInfoArr = [];

    plass = cell2mat(trainCell(:,1)); % only 3 values(1,2,3), no discretization
    featureNameArr{1} = 'pclass';
    mutualInfoArr(1) = mutual_information(trainSurv, trainSurv, plass);

    name=trainCell(:,2);
    featureNameArr{2} = 'name';
    mutualInfoArr(2) = mutual_information(trainSurv, trainSurv, name);

    sex=trainCell(:,3);
    featureNameArr{3} = 'sex';
    mutualInfoArr(3) = mutual_information(trainSurv, trainSurv, sex);

    age = cell2mat(trainCell(:,4));
    ageIdx = not(isnan(age));
    age=age(ageIdx);
    trainSurvAge = trainSurv(ageIdx);
    featureNameArr{4} = 'age';
    mutualInfoArr(4) = mutual_information(trainSurv, trainSurvAge, age);

    sibsp=cell2mat(trainCell(:,5));
    featureNameArr{5} = 'sibsp';
    mutualInfoArr(5) = mutual_information(trainSurv, trainSurv, sibsp);


    parch=cell2mat(trainCell(:,6));
    featureNameArr{6} = 'parch';
    mutualInfoArr(6) = mutual_information(trainSurv, trainSurv, parch);

    ticket = cellfun(@num2str,trainCell(:,7), 'UniformOutput',false);
    featureNameArr{7} = 'ticket';
    mutualInfoArr(7) = mutual_information(trainSurv, trainSurv, ticket);

    fare=cell2mat(trainCell(:,8));
    fareIdx = not(isnan(fare));
    fare=fare(fareIdx);
    trainSurvfare = trainSurv(fareIdx);
    featureNameArr{8} = 'fare';
    mutualInfoArr(8) = mutual_information(trainSurv, trainSurvfare, fare);

    [trainSurvCabin, cabin] = remove_nan_from_cell(trainSurv, trainCell(:,9));
    featureNameArr{9} = 'cabin';
    mutualInfoArr(9) = mutual_information(trainSurv, trainSurvCabin, cabin);

    [trainSurvEmbarked, embarked] = remove_nan_from_cell(trainSurv, trainCell(:,10));
    featureNameArr{10} = 'embarked';
    mutualInfoArr(10) = mutual_information(trainSurv, trainSurvEmbarked, embarked);

    [trainSurvBoat, boat] = remove_nan_from_cell(trainSurv, trainCell(:,11));
    boat = cellfun(@num2str,boat, 'UniformOutput',false);
    featureNameArr{11} = 'boat';
    mutualInfoArr(11) = mutual_information(trainSurv, trainSurvBoat, boat);

    [trainSurvBody, body] = remove_nan_from_cell(trainSurv, trainCell(:,12));
    body=cell2mat(body);
    featureNameArr{12} = 'body';
    mutualInfoArr(12) = mutual_information(trainSurv, trainSurvBody, body);

    [trainSurvHomeDest, homeDest] = remove_nan_from_cell(trainSurv, trainCell(:,13));
    featureNameArr{13} = 'homeDest';
    mutualInfoArr(13) = mutual_information(trainSurv, trainSurvHomeDest, homeDest);

    disp('mutual info in descending order-');
    [~,misi] = sort(mutualInfoArr, 'descend');
    for j=misi
        fprintf('%s = %f \n', featureNameArr{j}, mutualInfoArr(j));
    end