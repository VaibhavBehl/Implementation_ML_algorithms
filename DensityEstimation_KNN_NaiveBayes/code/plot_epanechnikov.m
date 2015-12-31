function plot_epanechnikov(data, hValues, refEstimate, refXValues)
    figure('name','Question 5.1(a)');
    for h=hValues
        %%estimator
        n=length(data);

        % p=ones(n,1); x=linspace(0,1,n); xi=p*x;
        % data2i=data*ones(1,n);


        estimatorX=0:0.00001:1;
        estimatorY=zeros(1, length(estimatorX));
        index=1;
        for ex=estimatorX %iterate for many x values to get good PD estimator
            exVector=zeros(n,1);
            exVector(:)=ex;
            u=(exVector-data)/h;
            absu=abs(u);
            indicatorVector=(absu<=1);% indicator function vector
            f=(3/4)*(1-u.^2).*indicatorVector;% to satisfy condition |u|<=1
            estimatorY(index)= mean(f)/h;
            index=index+1;
        end
        subplot(2,3,find(hValues==h));
        plot(estimatorX,estimatorY, 'b', refXValues, refEstimate, 'r');
        title(['Density Estimator for Epanechnikov with h = ' num2str(h)]);
        legend('With x\_tr', 'Reference');
        xlabel('x');
        ylabel('Density Function');
    end
end