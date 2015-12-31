function do_batch_gradient(trainX, trainSurv, testX, testSurv, currentFeatureIndexArray)

trX = [ones(size(trainX,1),1) trainX(:, currentFeatureIndexArray)];
teX = [ones(size(testX,1),1) testX(:, currentFeatureIndexArray)];
alpha = [0.001 0.01];

for j=1:length(alpha)
    fprintf('\n The accuracy for step size %f :\n', alpha(j));
    theta = zeros(1, size(trX,2));
    for k=1:3000
        gradient = get_cost(trX, trainSurv, theta);
        theta = theta + alpha(j)*gradient';
        if rem(k,500) == 0
            fprintf('Accuracy for iterations %d :\n', k);
            [trainAccu, testAccu] = calculate_tr_te_accuracy(trX, trainSurv, teX, testSurv, theta);
            fprintf('Train accuracy - %f %% \n', trainAccu);
            fprintf('Test accuracy - %f %% \n', testAccu);
        end
    end
end