function [descritizationPoints] = get_descritization_Points(input)
% will return 10 descritizationPoints for (almost)equal 10 density bins
% each element in descritizationPoints array will be the upper-bound for
% the bin.

%remove NAN values while computing descrete points
nonNanInput = input(not(isnan(input)));

[sv, ~] = sort(nonNanInput);
binNumber=10;
descritizationPoints = zeros(binNumber,1);
frac = round(length(nonNanInput)/binNumber);
% binI = 1,2,3,4,5... 10 bins... frac = length(input)/10 .. si[1:frac]
% .. si[frac+1 
for j=1:binNumber
    if j~=binNumber
        descritizationPoints(j) = sv(j*frac);
    else %for last bin include all remaining
        descritizationPoints(j) = sv(length(sv));
    end
end