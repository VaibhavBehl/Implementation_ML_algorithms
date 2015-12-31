function plot_integrated_variance_gaussian(allSubsetData, hValues)

    [k, subsetSize] = size(allSubsetData);
    
    integratedVariance = zeros(1, length(hValues));
    %Gaussian
    for h=hValues
        finalApproximationSummation = 0;
        for x=linspace(0, 1, 50) % approximating the integral by summing over 50 evenly spaced points in the unit interval. 

            %calculating impirical mean of all n subsets over 'x' data
            sumForImpiricalMean = 0;
            for ki=1:k % for all 'k=19' subsets
                subsetData = allSubsetData(ki,:); % data for nth subset

                % finding estimator of nth subset for x value
                sum=0;
                for ii=1:subsetSize
                   xi = subsetData(ii);
                   sum=sum + (1/sqrt(2*pi))*exp(-(((x-xi)/h)^2)/2);
                end
                sumForImpiricalMean = sumForImpiricalMean + sum/(subsetSize*h);
            end
            impiricalMeanOfNSubsets = sumForImpiricalMean/k;
            %---------------------------------------------------------

            summationOverSubsets = 0;
            for ki=1:k % for all 'k=19' subsets
                subsetData = allSubsetData(ki,:); % data for nth subset

                % finding estimator of nth subset for x value
                sum=0;
                for ii=1:subsetSize
                   xi = subsetData(ii);
                   sum=sum + (1/sqrt(2*pi))*exp(-(((x-xi)/h)^2)/2);
                end
                estimatorOfNthSubset = sum/(subsetSize*h);
                summationOverSubsets = summationOverSubsets + (estimatorOfNthSubset - impiricalMeanOfNSubsets)^2;
            end
            finalApproximationSummation = finalApproximationSummation + summationOverSubsets/k; %normalizing result by dividing by total subsets
        end
        integratedVariance(find(hValues == h)) = finalApproximationSummation;
    end
    plot(hValues, integratedVariance, 'blue');
end