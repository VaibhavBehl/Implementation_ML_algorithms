function [accuracy, trainTime] = own_linear(xTr, yTr, xTe, yTe, C)

tic;
[predW, bias] = trainsvm(xTr, yTr, C);
trainTime = toc;
accuracy = testsvm(xTe, yTe, predW, bias);

