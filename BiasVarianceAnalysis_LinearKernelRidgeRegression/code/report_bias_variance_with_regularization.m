function report_bias_variance_with_regularization(datasets,samples,lambda)


for lambdaValue = lambda
    dataxi = unifrnd(-1,1,datasets,samples);
    fx = @(x) 2*x.^2 + normrnd(0,sqrt(.1)); % expects a scalar value
    datayi = zeros(datasets,samples);
    for j=1:datasets
        for k=1:samples
            datayi(j,k) = fx(dataxi(j,k));
        end
    end

    gwSum = zeros(3,1);
    yPredAll = zeros(datasets,samples);
    for j=1:datasets
        Y = datayi(j,:)';
        yPred = zeros(samples,1);
        X = [ones(samples,1) dataxi(j,:)' dataxi(j,:)'.^2];

        w = (X'*X + lambdaValue.*eye(3))\(X'*Y);
        gwSum = gwSum + w;
        for k=1:samples
            yPred(k) = w(1) + w(2)*dataxi(j,k) + w(3)*dataxi(j,k)^2;
            yPredAll(j,k) = yPred(k);
        end
    end
    gwMean = gwSum/datasets;
    total = datasets*samples;
    dataxiVec = reshape(dataxi, total,1);
    yVec = 2.*(dataxiVec.^2); % without noise

    egyVec = gwMean(1) + dataxiVec*gwMean(2) + (dataxiVec.^2)*gwMean(3);
    gBias = (norm(yVec - egyVec)^2)/total;
    gVar = (norm(reshape(yPredAll,total,1) - egyVec)^2)/total;
    fprintf('For Lambda = %0.2f : Bias = %f, Variance = %f\n', lambdaValue, gBias, gVar);
end
