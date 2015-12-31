function plot_histogram(data, binWidthValues, refEstimate, refXValues)

    N = length(data);
    lower=0;
    upper=1;
    figure('name','Question 5.1(a)');
    for binWidth=binWidthValues
        noBins=(upper-lower)/binWidth;
        histArrayY=zeros(1, ceil(noBins));
        for bi=0:binWidth:1
            lowerBound=bi;
            upperBound=bi+binWidth;
            if lowerBound<1 %if lower bound reaches 1, no need to continue
                histArrayIndex=round(upperBound/binWidth);
                if upperBound > 1 %for final iteration of loop
                    upperBound = 1;
                end
                histArrayY(histArrayIndex)=length(data(data>=lowerBound & data<upperBound))/(N*binWidth);
            end
        end

        %%estimator
        estimatorX=0.00001:0.00001:1;
        estimatorY=zeros(1, length(estimatorX));
        index=1;
        for ei=estimatorX
            arrayIndex = ceil(ei/binWidth);
            estimatorY(index)= histArrayY(arrayIndex);
            index=index+1;
        end
        subplot(2,3,find(binWidthValues==binWidth));
        plot(estimatorX,estimatorY, 'b', refXValues, refEstimate, 'r');
        title(['Density Estimator for Histogram with h = ' num2str(binWidth)]);
        legend('With x\_tr', 'Reference');
        xlabel('x');
        ylabel('Density Function');
    end
end
