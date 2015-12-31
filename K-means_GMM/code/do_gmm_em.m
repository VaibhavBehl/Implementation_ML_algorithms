function [likelihoodVector,logAllPosteriorZGivenX,mu,sigma] = do_gmm_em(X, numComponent)
    [N,M] = size(X);
    likelihoodVector = [];
    % initializing params
    mu = zeros(numComponent,M);
    for i=1:numComponent
        for j=1:M
            minx = min(X(:,j));
            maxx = max(X(:,j));
            mu(i,j) = minx+(maxx - minx)*rand(1,1);
        end
    end
    sigma = zeros(M, M, numComponent);
    for i=1:M
        for j=1:M
            for k=1:numComponent
                if (i==j)
                    sigma(i,j,k) = var(X(:,i));
                end
            end
        end
    end
    % prior probability(p(z)) for each component
    weightK = ones(1,numComponent) * 1/numComponent;

    % calculating initial log-likelyhood
    oldLikelyhood = calculateLikelyhood(X,mu,sigma,weightK,N,numComponent);
    likelihoodVector = [likelihoodVector oldLikelyhood];
    %fprintf('\noldLikelyhood->%f\n',oldLikelyhood);
    
    countIter = 1;
    while(1)
        %E step: calculating posterior probability using current params 
        logSumNrNK = zeros(N, numComponent); %Numerator: log(p(x|z)*p(z))
        for n=1:N
            for k=1:numComponent
                logSumNrNK(n,k) = log(mvnpdf(X(n,:),mu(k,:),sigma(:,:,k))) ...
                    + log(weightK(1, k));
            end
        end

        logSumDrN = returnlogSum(logSumNrNK,2);% Denominator: \sum(k=1)^K p(x|z=k)p(z=k)
        % calculating log posterior p(z_n=k|x_n) for all (n,k) pair
        logAllPosteriorZGivenX = zeros(N, numComponent);
        for n=1:N
            for k=1:numComponent
                logAllPosteriorZGivenX(n,k) = logSumNrNK(n,k)-logSumDrN(n);       
            end
        end

        %M step: calculating parameters from the current posterior probability,
        % using MLE equations from lecture slides

        % Calculating responsibility sum over all data points (indexed by
        % K-component)
        logResponsibilitySumK = returnlogSum(logAllPosteriorZGivenX, 1);

        %estimating mu
        for k=1:numComponent
            for d=1:M
                muSum = 0;
                for n=1:N
                   muSum = muSum+exp(logAllPosteriorZGivenX(n,k)-logResponsibilitySumK(k))*X(n,d); 
                end
                mu(k,d) = muSum;
            end
        end

        %estimating sigma
        for k=1:numComponent
            muSum = 0;
            for n=1:N
                % when computing covariance vertical vector * horizontal verctor
                % (see covariance.m in examples).
                muSum = muSum + exp(logAllPosteriorZGivenX(n,k) - logResponsibilitySumK(k)) * (X(n,:)-mu(k,:))'*(X(n,:)-mu(k,:)); 
            end
            sigma(:,:,k) = muSum;
        end

        %estimating weightK
        for k=1:numComponent
            weightK(k) = exp(logResponsibilitySumK(k))/N;
        end

        %Calculate new log-likelihood
        newLikelihood = calculateLikelyhood(X,mu,sigma,weightK,N,numComponent);    
        likelihoodVector = [likelihoodVector newLikelihood];
        %fprintf('\nnewLikelihood->%f\n',newLikelihood);
        
        % to stop EM iterations
        if(countIter>50||(newLikelihood - oldLikelyhood >= 0 && newLikelihood < oldLikelyhood + 1e-6))
            disp('successful termination');
            break;
        else
            countIter = countIter + 1;
        end
        oldLikelyhood = newLikelihood;
    end
end

function [likelyhood] = calculateLikelyhood(X,mu,sigma,weightK,N,numComponent)
    likelyhood = 0;
    for nn=1:N
        logSumK = zeros(1, numComponent);
        for kk=1:numComponent
            logSumK(kk) = log(mvnpdf(X(nn,:),mu(kk,:),sigma(:,:,kk))) ...
                + log(weightK(1, kk));
        end
        % summation internal over all numComponent
        logSumK = returnlogSum(logSumK,2);
        % sumation external over all N
        likelyhood = likelyhood + logSumK;
    end
end

%to prevent underflow problem
function retVal = returnlogSum(vectorX, dimension)
    maxx = max(vectorX,[],dimension);
    vectorX = bsxfun(@minus,vectorX,maxx);
    retVal = maxx + log(sum(exp(vectorX),dimension));
end