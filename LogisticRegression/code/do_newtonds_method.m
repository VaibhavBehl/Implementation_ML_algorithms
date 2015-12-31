function do_newtonds_method(trainX, trainSurv, testX, testSurv, currentFeatureIndexArray);

trX = [ones(size(trainX,1),1) trainX(:, currentFeatureIndexArray)];
teX = [ones(size(testX,1),1) testX(:, currentFeatureIndexArray)];

trXCols = size(trX,2);
theta=zeros(trXCols, 1);
sigmoidFun = inline('1.0 ./ (1.0 + exp(-z))');

for noOfIter=1:5
    fprintf('\nAccuracy for iteration %d :\n', noOfIter);
    for k = 1:noOfIter
        hypo = sigmoidFun(trX*theta);
        gradient = trX'*(hypo-trainSurv);
        hessian = trX' * diag(hypo) * diag(1-hypo) * trX;
        theta = theta-hessian\gradient;
    end
    trPredValues=sigmoidFun(trX*theta);
    trPredClass=trPredValues>0.5;
    trainAccu = sum(trPredClass(:,1)==trainSurv)/length(trainSurv);
    fprintf('Train Accuracy = %f\n', trainAccu);
    
    tePredValues=sigmoidFun(teX*theta);
    tePredClass=tePredValues>0.5;
    testAccu = sum(tePredClass(:,1)==testSurv)/length(testSurv);
    fprintf('Test Accuracy = %f\n', testAccu);
 end