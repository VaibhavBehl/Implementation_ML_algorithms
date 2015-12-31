function [] = plot_kernel_kmean(dataPts,K)

N = length(dataPts);
comp1 = dataPts(:,1).^2+dataPts(:,2).^2;
comp2 = dataPts(:,2).^2+dataPts(:,1).^2;
KMat = comp1*comp2';

% random init cluster mean points
%uk = zeros(K,2); % one cluster mean per row
randNos = ceil(rand(K,1)*N);
rnk = zeros(N,1); % changed to a 1toK vector, easier to gscatter
for i=1:K
    rnk(randNos(i)) = i;
    %rnk(i) = ceil(rand(1,1)*K);
    %uk(i,1) = dataPts(randNos(i),1);% + rand(1,1)/100;
    %uk(i,2) = dataPts(randNos(i),2);% + rand(1,1)/100;
end

% rnk(1) = 1;
% rnk(396) = 2;

% % % what the output should be
% % rnk(:) = 1;
% % margin = 0.65;
% % rnk(dataPts(:,1)>-margin & dataPts(:,1)<margin & dataPts(:,2)>-margin & dataPts(:,2)<margin) = 2;

%hold on;
gscatter(dataPts(:,1),dataPts(:,2),rnk);
%plot(dataPts(rnk==1,1),dataPts(rnk==1,2),'x');
%plot(dataPts(rnk==2,1),dataPts(rnk==2,2),'x');
%hold off;


% [label,U] = kernel_kmeans(K,KMat);
% %[label, energy] = knkmeans(KMat,rnk');
% figure;
% gscatter(dataPts(:,1),dataPts(:,2),label,'rgbcm','xo^+d');

updatedRnk = rnk;

changed = true;
count = 0;
changedCount = 0;
while changed && count<100
    rnk = updatedRnk;
    disp(strcat('count=',int2str(count)));
    changed = false;
    count = count + 1;
    % calcuate dist and update cluster points
    for i=1:N
        %dist = zeros(K,1);
        disp(strcat('i=',int2str(i)));
        
        % dist now need to be calculated over all points for each cluster
        distv = zeros(K,1);
        for j=1:K
            %for ith point, calculate distance with points currently in
            %cluster j
            clusterJidx = find(rnk==j);
            sumTerm1=KMat(i,i);
            sumTerm2=0;
            sumTerm3=0;
            for jidx = 1:size(clusterJidx,1)
                sumTerm2 = sumTerm2 + KMat(i,clusterJidx(jidx));
                for lidx = 1:size(clusterJidx,1)
                    sumTerm3 = sumTerm3 + KMat(clusterJidx(jidx),clusterJidx(lidx));
                end
            end
            
            distv(j) = sumTerm1 - 2*sumTerm2/size(clusterJidx,1) + sumTerm3/size(clusterJidx,1).^2;
            if distv(j) <0
                error('less than zero');
            end
        end
        
        minIndex = find(distv == min(distv));
        if updatedRnk(i) ~= minIndex(1) % taking first index in case of tie
            updatedRnk(i) = minIndex(1);
            changed = true;
            changedCount = changedCount + 1;
        end
        %rnk = updatedRnk;
        if mod(i,250) == 0 % temp code
            %figure;
            %gscatter(dataPts(:,1),dataPts(:,2),updatedRnk,'rgbcm','xo^+d');
        end
    end
    %figure;
    %gscatter(dataPts(:,1),dataPts(:,2),updatedRnk,'rgbcm','xo^+d');
end
figure;
gscatter(dataPts(:,1),dataPts(:,2),updatedRnk,'rgbcm','xo^+d');

