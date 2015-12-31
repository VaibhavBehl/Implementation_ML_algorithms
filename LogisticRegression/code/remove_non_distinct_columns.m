function [inputMat, onlySingleDistinct] = remove_non_distinct_columns(inputMat)

[~, cols] = size(inputMat);
onlySingleDistinct = [];
for j=1:cols
    column = inputMat(:,j);
    uniqueValue = unique(column);
    count = 0;
    for i=1:length(uniqueValue)
        if not(isnan(uniqueValue(i)))
            count = count + 1;
        end
    end
    if count < 2
        onlySingleDistinct = [onlySingleDistinct j];
    end
end

inputMat(:, onlySingleDistinct) = [];