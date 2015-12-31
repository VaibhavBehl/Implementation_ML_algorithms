function plot_mse_and_report_bias_variance(datasets,samples)

dataxi = unifrnd(-1,1,datasets,samples);
fx = @(x) 2*x.^2 + normrnd(0,sqrt(.1)); % expects a scalar value
datayi = zeros(datasets,samples);
for j=1:datasets
    for k=1:samples
        datayi(j,k) = fx(dataxi(j,k));
    end
end

% finding parameters for all datasets and calculating MSE to plot histogram
G1=1;G2=2;G3=3;G4=4;G5=5;G6=6;
gCount = 6;
mse = zeros(gCount,datasets);
%sumBiasAll = zeros(6,1); % bias for all g_x functions
%sumVarAll = zeros(6,1); % variance for all g_x functions
g2wSum = zeros(1,1);
g3wSum = zeros(2,1);
g4wSum = zeros(3,1);
g5wSum = zeros(4,1);
g6wSum = zeros(5,1);
yPredAll = zeros(gCount,datasets,samples);

for j=1:datasets
    Y = datayi(j,:)';
    %YTrue = 2.*(dataxi(j,:)'.^2);
    yPred = zeros(samples,1);
    %meanYpred = zeros(samples,1);
    
    % -- g_1(x) = 1 directly try to calculate MSE for each datasets
    sse = 0;
    for k=1:samples
        yPred(k) = 1;
        yPredAll(G1,j,k) = yPred(k);
        sse = sse + (yPred(k)-Y(k)).^2;
    end
    mse(G1,j) = sse/samples;
    %sumBiasAll(G1) = sumBiasAll(G1) + (norm(yPred-YTrue)^2)/samples;
    %sumVarAll(G1) = sumVarAll(G1) + var(yPred);
    
    % -- g_2(x) = w_0
    X = ones(samples,1);
    w = (X'*X)\(X'*Y);
    g2wSum = g2wSum + w;
    sse = 0;
    for k=1:samples
        yPred(k) = w(1);
        yPredAll(G2,j,k) = yPred(k);
        sse = sse + (yPred(k)-Y(k)).^2;
    end
    mse(G2,j) = sse/samples;
    %meanYpred(:) = sum(yPred)/samples;
    %sumBiasAll(G2) = sumBiasAll(G2) + (norm(yPred-YTrue)^2)/samples;
    %sumVarAll(G2) = sumVarAll(G2) + var(yPred);
    
    % -- g_3(x) = w_0 + w_1.x
    X = [ones(samples,1) dataxi(j,:)'];
    w = (X'*X)\(X'*Y);
    g3wSum = g3wSum + w;
    sse = 0;
    for k=1:samples
        yPred(k) = w(1) + w(2)*dataxi(j,k);
        yPredAll(G3,j,k) = yPred(k);
        sse = sse + (yPred(k)-Y(k)).^2;
    end
    mse(G3,j) = sse/samples;
    %sumBiasAll(G3) = sumBiasAll(G3) + (norm(yPred-YTrue)^2)/samples;
    %sumVarAll(G3) = sumVarAll(G3) + var(yPred);
    
    % -- g_4(x) = w_0 + w_1.x + w_2.x^2
    X = [ones(samples,1) dataxi(j,:)' dataxi(j,:)'.^2];
    w = (X'*X)\(X'*Y);
    g4wSum = g4wSum + w;
    sse = 0;
    for k=1:samples
        yPred(k) = w(1) + w(2)*dataxi(j,k) + w(3)*dataxi(j,k)^2;
        yPredAll(G4,j,k) = yPred(k);
        sse = sse + (yPred(k)-Y(k)).^2;
    end
    mse(G4,j) = sse/samples;
    %sumBiasAll(G4) = sumBiasAll(G4) + (norm(yPred-YTrue)^2)/samples;
    %sumVarAll(G4) = sumVarAll(G4) + var(yPred);
    
    % -- g_5(x) = w_0 + w_1.x + w_2.x^2 + w_3.x^3
    X = [ones(samples,1) dataxi(j,:)' dataxi(j,:)'.^2 dataxi(j,:)'.^3];
    w = (X'*X)\(X'*Y);
    g5wSum = g5wSum + w;
    sse = 0;
    for k=1:samples
        yPred(k) = w(1) + w(2)*dataxi(j,k) + w(3)*dataxi(j,k)^2 + w(4)*dataxi(j,k)^3;
        yPredAll(G5,j,k) = yPred(k);
        sse = sse + (yPred(k)-Y(k)).^2;
    end
    mse(G5,j) = sse/samples;
    %sumBiasAll(G5) = sumBiasAll(G5) + (norm(yPred-YTrue)^2)/samples;
    %sumVarAll(G5) = sumVarAll(G5) + var(yPred);
    
    % -- g_6(x) = w_0 + w_1.x + w_2.x^2 + w_3.x^3 + w_4.x^4
    X = [ones(samples,1) dataxi(j,:)' dataxi(j,:)'.^2 dataxi(j,:)'.^3 dataxi(j,:)'.^4];
    w = (X'*X)\(X'*Y);
    g6wSum = g6wSum + w;
    sse = 0;
    for k=1:samples
        yPred(k) = w(1) + w(2)*dataxi(j,k) + w(3)*dataxi(j,k)^2 + w(4)*dataxi(j,k)^3 + w(5)*dataxi(j,k)^4;
        yPredAll(G6,j,k) = yPred(k);
        sse = sse + (yPred(k)-Y(k)).^2;
    end
    mse(G6,j) = sse/samples;
    %sumBiasAll(G6) = sumBiasAll(G6) + (norm(yPred-YTrue)^2)/samples;
    %sumVarAll(G6) = sumVarAll(G6) + var(yPred);
end

g2wMean = g2wSum/datasets;
g3wMean = g3wSum/datasets;
g4wMean = g4wSum/datasets;
g5wMean = g5wSum/datasets;
g6wMean = g6wSum/datasets;

total = datasets*samples;
gBias = zeros(gCount,1);
gVar = zeros(gCount,1);
dataxiVec = reshape(dataxi, total,1);
yVec = 2.*(dataxiVec.^2); % without noise

eg1yVec = ones(total, 1); % expected value is 1 for g1 func
gBias(G1) = (norm(yVec - eg1yVec)^2)/total;
gVar(G1) = (norm(reshape(yPredAll(G1,:,:),total,1) - eg1yVec)^2)/total;

eg2yVec = g2wMean(1)*ones(total, 1); % w0
gBias(G2) = (norm(yVec - eg2yVec)^2)/total;
gVar(G2) = (norm(reshape(yPredAll(G2,:,:),total,1) - eg2yVec)^2)/total;

eg3yVec = g3wMean(1) + dataxiVec*g3wMean(2);
gBias(G3) = (norm(yVec - eg3yVec)^2)/total;
gVar(G3) = (norm(reshape(yPredAll(G3,:,:),total,1) - eg3yVec)^2)/total;

eg4yVec = g4wMean(1) + dataxiVec*g4wMean(2) + (dataxiVec.^2)*g4wMean(3);
gBias(G4) = (norm(yVec - eg4yVec)^2)/total;
gVar(G4) = (norm(reshape(yPredAll(G4,:,:),total,1) - eg4yVec)^2)/total;

eg5yVec = g5wMean(1) + dataxiVec*g5wMean(2) + (dataxiVec.^2)*g5wMean(3) + (dataxiVec.^3)*g5wMean(4);
gBias(G5) = (norm(yVec - eg5yVec)^2)/total;
gVar(G5) = (norm(reshape(yPredAll(G5,:,:),total,1) - eg5yVec)^2)/total;

eg6yVec = g6wMean(1) + dataxiVec*g6wMean(2) + (dataxiVec.^2)*g6wMean(3) + (dataxiVec.^3)*g6wMean(4) + (dataxiVec.^4)*g6wMean(5);
gBias(G6) = (norm(yVec - eg6yVec)^2)/total;
gVar(G6) = (norm(reshape(yPredAll(G6,:,:),total,1) - eg6yVec)^2)/total;

for gg=1:6
    fprintf('For g_%d(x): Bias = %f, Variance = %f\n', gg, gBias(gg), gVar(gg));
end


figure;
subplot(3,2,1);
hist(mse(G1,:),10);
title(strcat('Sample Size = ',int2str(samples),'. Histogram plot of Mean Squared Error for g_1(x) function'));
xlabel('MSE');
ylabel('#');
subplot(3,2,2);
hist(mse(G2,:),10);
title(strcat('Sample Size = ',int2str(samples),'. Histogram plot of Mean Squared Error for g_2(x) function'));
xlabel('MSE');
ylabel('#');
subplot(3,2,3);
hist(mse(G3,:),10);
title(strcat('Sample Size = ',int2str(samples),'. Histogram plot of Mean Squared Error for g_3(x) function'));
xlabel('MSE');
ylabel('#');
subplot(3,2,4);
hist(mse(G4,:),10);
title(strcat('Sample Size = ',int2str(samples),'. Histogram plot of Mean Squared Error for g_4(x) function'));
xlabel('MSE');
ylabel('#');
subplot(3,2,5);
hist(mse(G5,:),10);
title(strcat('Sample Size = ',int2str(samples),'. Histogram plot of Mean Squared Error for g_5(x) function'));
xlabel('MSE');
ylabel('#');
subplot(3,2,6);
hist(mse(G6,:),10);
title(strcat('Sample Size = ',int2str(samples),'. Histogram plot of Mean Squared Error for g_6(x) function'));
xlabel('MSE');
ylabel('#');