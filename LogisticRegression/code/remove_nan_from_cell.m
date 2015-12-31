function [ANew, BNew] = remove_nan_from_cell(A,B)
% This function will remove 'NaN' values from B and corresponding values
% from A
notNanFun = @(x) any(not(isnan(x)));
BNonNanIdx = cellfun(notNanFun,B);
BNew = B(BNonNanIdx);
ANew = A(BNonNanIdx);