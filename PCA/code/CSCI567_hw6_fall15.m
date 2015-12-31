% CSCI-567 HW#6
% 3 Programming
fprintf('\n\n');
disp('4 Programming');

% 3.1 PCA
% 3.1 a)
fprintf('\n\n');
disp('3.1 a)');
hw6_pca = load('hw6_pca.mat');
xTr = hw6_pca.X.train;
yTr = hw6_pca.y.train;
xTe = hw6_pca.X.test;
yTe = hw6_pca.y.test;

eigenvecs = get_sorted_eigenvecs(xTr);

% 3.1 b)
disp('3.1 b)');
figure;
hold on;
for i = 1:8
    subplot(4,4,i);
    imshow(double(reshape(eigenvecs(:,i), 16, 16)),[]);
end
hold off;

% 3.1 c)
disp('3.1 c)');
figure;
hold on;
imgSet = [5500,6500,7500,8000,8500];
pcSet = [0,1,5,10,20,80];
cc=1;
for pc = pcSet
    for imgno = imgSet
        subplot(6,5,cc);
        cc=cc+1;
        if pc==0
            imshow(double(reshape(xTr(imgno,:), 16, 16)),[]);
            title(strcat('raw image #',num2str(imgno)));
        else
            evless = eigenvecs(:,1:pc);
            xtrLess = xTr*evless;
            xtrRecon = xtrLess*evless';
            imshow(double(reshape(xtrRecon(imgno,:), 16, 16)),[]);
            title(strcat('s#',num2str(imgno),',pc#',num2str(pc)));
        end
    end
end
hold off;

% 3.1 d)
disp('3.1 d)');
xTrEV = get_sorted_eigenvecs(xTr);
[nTr,~] = size(xTr);
[nTe,~] = size(xTe);
xTr = xTr - repmat(mean(xTr),nTr,1);
xTe = xTe - repmat(mean(xTr),nTe,1);

pcSet = [1,5,10,20,80];
for pc = pcSet
    tic;
    xTrEVless = xTrEV(:,1:pc);
    xTrLess = xTr*xTrEVless;
    %xTrRecon = xTrLess*xTrEVless';
    
    xTeEVless = xTrEV(:,1:pc);
    xTeLess = xTe*xTrEVless;
    %xTeRecon = xTeLess*xTeEVless';
    
    tree = ClassificationTree.fit(xTrLess,yTr,'SplitCriterion', 'deviance');
    yTrPredict = predict(tree,xTrLess);
    fprintf('\n training accuracy for pc%d = %0.2f',pc,100*sum(yTrPredict==yTr)/length(yTr));
    yTePredict = predict(tree,xTeLess);
    fprintf('\n testing accuracy for pc%d = %0.2f',pc,100*sum(yTePredict==yTe)/length(yTe));
    fprintf('\n time taken = %0.2f seconds',toc);
end

x=VarName1;
% 3.2 a)

y = zeros(size(x));

for i = 1:length(x)

y(i) = sum(x==x(i));

end
















