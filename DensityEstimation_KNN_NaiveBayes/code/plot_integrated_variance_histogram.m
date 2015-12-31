function plot_integrated_variance_histogram(allSubsetData, hValues)

    [k, subsetSize] = size(allSubsetData);
    
    integratedVariance = zeros(1, length(hValues));
    %epanechnikov
    upper=1;
    lower=0;
    
    for h=hValues
        finalApproximationSummation = 0;
        for x=linspace(0, 1, 50) % approximating the integral by summing over 50 evenly spaced points in the unit interval. 

            %--calculating impirical mean of all n subsets over 'x' data---
            sumForImpiricalMean = 0;
            for ki=1:k % for all 'k=19' subsets
                subsetData = allSubsetData(ki,:); % data for nth subset
                
                noBins=(upper-lower)/h;
                histArrayY=zeros(1, ceil(noBins));
                for bi=0:h:1
                    lowerBound=bi;
                    upperBound=bi+h;
                    if lowerBound<1 %if lower bound reaches 1, no need to continue
                        histArrayIndex=round(upperBound/h);
                        if upperBound > 1 %for final iteration of loop
                            upperBound = 1;
                        end
                        histArrayY(histArrayIndex)=length(subsetData(subsetData>=lowerBound & subsetData<upperBound))/(subsetSize*h);
                    end
                end
                %%estimator
                arrayIndex = ceil(x/h);
                if arrayIndex == 0
                    arrayIndex = 1; %making array index 1 if found zero
                end
                sumForImpiricalMean = sumForImpiricalMean + histArrayY(arrayIndex);
            end
            impiricalMeanOfNSubsets = sumForImpiricalMean/k;
            %--------------------------------------------------------------

            summationOverSubsets = 0;
            for ki=1:k % for all 'k=19' subsets
                subsetData = allSubsetData(ki,:); % data for nth subset

                % finding estimator of nth subset for x value
                noBins=(upper-lower)/h;
                histArrayY=zeros(1, ceil(noBins));
                for bi=0:h:1
                    lowerBound=bi;
                    upperBound=bi+h;
                    if lowerBound<1 %if lower bound reaches 1, no need to continue
                        histArrayIndex=round(upperBound/h);
                        if upperBound > 1 %for final iteration of loop
                            upperBound = 1;
                        end
                        histArrayY(histArrayIndex)=length(subsetData(subsetData>=lowerBound & subsetData<upperBound))/(subsetSize*h);
                    end
                end
                %%estimator
                arrayIndex = ceil(x/h);
                if arrayIndex == 0
                    arrayIndex = 1; %making array index 1 if found zero
                end
                estimatorOfNthSubset = histArrayY(arrayIndex);
                summationOverSubsets = summationOverSubsets + (estimatorOfNthSubset - impiricalMeanOfNSubsets)^2;
            end
            finalApproximationSummation = finalApproximationSummation + summationOverSubsets/k; %normalizing result by dividing by total subsets
        end
        integratedVariance(find(hValues == h)) = finalApproximationSummation;
    end
    plot(hValues, integratedVariance, 'black');
end