function [] = plot_cluster(dataPts, K)

N = length(dataPts);
% random init cluster mean points
uk = zeros(K,2); % one cluster mean per row
randNos = ceil(rand(K,1)*N);
for i=1:K
    uk(i,1) = dataPts(randNos(i),1);% + rand(1,1)/100;
    uk(i,2) = dataPts(randNos(i),2);% + rand(1,1)/100;
end

%rnk = zeros(N,K); % 1-0 matrix having indicator variable
rnk = zeros(N,1); % changed to a 1toK vector, easier to gscatter

changed = true;
count = 0;
while changed
    changed = false;
    count = count + 1;
    % init rnk
    for i=1:N
        %dist = zeros(K,1);
        dist = uk - repmat(dataPts(i,:),K,1);
        normv = zeros(K,1);
        for j=1:K
            normv(j) = norm(dist(j,:)).^2;
        end
        minIndex = find(normv == min(normv));
        if rnk(i) ~= minIndex(1) % taking first index in case of tie
            rnk(i) = minIndex(1);
            changed = true;
        end
    end
    % update uk to the new mean of the clusters
    for i=1:K
        rnki = rnk==i; % indicator valirable for ith column
        uk(i,1) = sum(rnki.*dataPts(:,1))/sum(rnki);
        uk(i,2) = sum(rnki.*dataPts(:,2))/sum(rnki);
    end
    %figure;
    %gscatter(dataPts(:,1),dataPts(:,2), rnk, 'rgbcm','xo^+d');
end
figure;
gscatter(dataPts(:,1),dataPts(:,2),rnk,'rgbcm','xo^+d');
