function plot_gaussian(data, hValues, refEstimate, refXValues)
    N = length(data);
    figure('name','Question 5.1(a)');
    for h=hValues
        %%estimator
        estimatorX=0:0.00001:1;
        estimatorY=zeros(1, length(estimatorX));
        index=1;
        for x=estimatorX
            
            sum=0;
            for ii=1:N
               xi = data(ii);
               sum=sum + (1/sqrt(2*pi))*exp(-(((x-xi)/h)^2)/2);
            end
            estimatorY(index)= sum/(N*h);
            index=index+1;
        end
        subplot(2,3,find(hValues==h));
        plot(estimatorX,estimatorY, 'b', refXValues, refEstimate, 'r');
        title(['Density Estimator for Gaussian with h = ' num2str(h)]);
        legend('With x\_tr', 'Reference');
        xlabel('x');
        ylabel('Density Function');
    end
end