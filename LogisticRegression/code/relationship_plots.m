function relationship_plots(trainCell, trainSurv)

    % For(pclass, age, sibsp, parch, fare) discretized into 10 equal-width bins
    % and plot against probability of survival.
    figure;
    % -- pclass(1) --
    pclass = cell2mat(trainCell(:,1)); % only 3 values - 1,2,3
    surv1 = sum(trainSurv(pclass==1))/length(trainSurv(pclass==1));
    surv2 = sum(trainSurv(pclass==2))/length(trainSurv(pclass==2));
    surv3 = sum(trainSurv(pclass==3))/length(trainSurv(pclass==3));
    probPclass = [surv1, surv2, surv3];
    xAxis = [1, 2, 3];
    subplot(2,3,1);
    bar(xAxis, probPclass);
    title('Probability of Survival plot for ''pclass'' variable');
    xlabel('pclass value');

    % -- age(4) --
    age = cell2mat(trainCell(:,4)); % have to discretise into 10 bins
    ageRanges = linspace(min(age), max(age)+0.0001, 11);
    binValues = zeros(1,10); % value for 10 bins
    xAxis = 1:10; % x-axis bins
    for j=xAxis
        trainSurvForBin = trainSurv(age>=ageRanges(j) & age<ageRanges(j+1));
        binValues(j) = sum(trainSurvForBin)/length(trainSurvForBin);
    end
    subplot(2,3,2);
    bar(xAxis, binValues);
    title('Probability of Survival plot for ''age'' variable');
    xlabel('bin number');

    % -- sibsp(5) --
    sibsp = cell2mat(trainCell(:,5)); % only 7 unique values - 0, 1, 2, 3, 4, 5, 8
    uniqueSibspValues = unique(sibsp).';
    binValues = zeros(1,length(uniqueSibspValues)); % value for each unique bin
    for j = uniqueSibspValues
        trainSurvForBin = trainSurv(sibsp==j);
        binValues(uniqueSibspValues == j) = sum(trainSurvForBin)/length(trainSurvForBin);
    end
    subplot(2,3,3);
    bar(binValues);
    set(gca,'XtickL',uniqueSibspValues);
    title('Probability of Survival plot for ''sibsp'' variable');
    xlabel('sibsp value');

    % -- parch(6) --
    parch = cell2mat(trainCell(:,6));% only 8 unique values - 0, 1, 2, 3, 4, 5, 6, 9
    uniqueParchValues = unique(parch).';
    binValues = zeros(1,length(uniqueParchValues)); % value for each unique bin
    for j = uniqueParchValues
        trainSurvForBin = trainSurv(parch==j);
        binValues(uniqueParchValues == j) = sum(trainSurvForBin)/length(trainSurvForBin);
    end
    subplot(2,3,4);
    bar(binValues);
    set(gca,'XtickL',uniqueParchValues);
    title('Probability of Survival plot for ''parch'' variable');
    xlabel('parch number');

    % -- fare(8) --
    fare = cell2mat(trainCell(:,8)); % have to discretise into 10 bins
    fareRanges = linspace(min(fare), max(fare)+0.0001, 11);
    binValues = zeros(1,10); % value for 10 bins
    xAxis = 1:10; % x-axis bins
    for j=xAxis
        trainSurvForBin = trainSurv(fare>=fareRanges(j) & fare<fareRanges(j+1));
        binValues(j) = sum(trainSurvForBin)/length(trainSurvForBin);
    end
    subplot(2,3,5);
    bar(xAxis, binValues);
    title('Probability of Survival plot for ''fare'' variable');
    xlabel('bin number');
end