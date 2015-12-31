% CSCI-567 HW#5
% 4 Programming
fprintf('\n\n');
disp('4 Programming');

% 4.1 Data
fprintf('\n\n');
disp('4.1 Data');
hw5_blob = load('hw5_blob.mat');
blobPts = hw5_blob.points; % Nx2 dimenstion
hw5_circle = load('hw5_circle.mat');
circlePts = hw5_circle.points; % Nx2 dimension

% 4.2 Implement k-means
plot_cluster(blobPts, 2);
plot_cluster(blobPts, 3);
plot_cluster(blobPts, 5);
plot_cluster(circlePts, 2);
plot_cluster(circlePts, 3);
plot_cluster(circlePts, 5);

% 4.3 Implement kernel k-means
dataPts = circlePts;
K=2;
plot_kernel_kmean(dataPts,K);

% 4.4 Implement Gaussian Mixture Model

% for 5 iterations
disp('a) plots for 5 iterations');
dataPts = blobPts;
lineSpec = ['- ';'--';': ';'-.';'-*'];
maxLikelihood = -inf;
figure;
hold on;
for i=1:5
    [likelihoodVector,logAllPosteriorZGivenX,mu,sigma] = do_gmm_em(dataPts, 3);
    fprintf('for iteration %d',i);
    disp(mat2str(likelihoodVector));
    if likelihoodVector(end)>maxLikelihood
        maxLikelihood = likelihoodVector(end);
        mlogAllPosteriorZGivenX = logAllPosteriorZGivenX;
        mmu = mu;
        msigma=sigma;
    end
    plot(likelihoodVector,lineSpec(i,:));
    xlabel('Number of iterations');
    ylabel('log-likelyhood with current parameters');
end
hold off;

disp('b) 1. cluster assignment for best run');
[N,~] = size(dataPts);
label = zeros(N,1);
for i=1:N
    a = mlogAllPosteriorZGivenX(i,:);
    label(i) = find(max(a) == a);
end
figure;
gscatter(dataPts(:,1),dataPts(:,2),label,'rgbcm','xo^+d');

disp('c) 1. Mean and Covariance matrix for best run');
disp('mean:');
disp(mmu);
disp('covariance:');
disp(msigma);
