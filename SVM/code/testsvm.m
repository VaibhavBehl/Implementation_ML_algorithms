function [accuracy] = testsvm(xTe, yTe, predW, bias)

biasV = ones(size(xTe,1),1)*bias;

yhat = (predW' * xTe') + biasV';
yhatClass = inf(length(yhat),1);

for i = 1:length(yhat)
    if yhat(i) >= 0
        yhatClass(i) = 1;
    else
        yhatClass(i) = -1;   
    end
end

accuracy = sum(yTe == yhatClass)/length(yhatClass);