function [allSubsetData] = split_randomly_into_k_subsets(data, k)
    %randomly divide data into K subsets
    n=length(data);
    xpos = randperm(n); %random permutations of n values
    partitionPoints = round(linspace(1, n+1, k+1));% using k+1 to have k bins
    subsetSize = abs(n/k);
    allSubsetData = zeros(k, subsetSize); % 19x500 matrix with random values
    for ki=1:k
        index=partitionPoints(ki):partitionPoints(ki+1) - 1;
        allSubsetData(ki,:)=data(xpos(index));
    end
end