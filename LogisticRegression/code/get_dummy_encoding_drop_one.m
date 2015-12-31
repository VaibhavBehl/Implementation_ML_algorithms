function [dummyVariableLastColumnDropped] = get_dummy_encoding_drop_one(nominalInput, allInput, nanPossible)
% this function will return the dummy variable encoding for the 'nominal'
% categorical input array after dropping LAST column from encodin output.
% NOTE- 'allInput' here is used just to keep ENCODING consistent, so that
% the number of columns are same between the final TrainX and TestX
% matrices.

%removing NAN's from allInput
allInputNonNan = allInput;
if nanPossible
    allInputNonNan = allInput(not(isnan(allInput)));
end
uniqueAllInputValues = unique(allInputNonNan);
dummyEncodingMat = zeros(length(nominalInput), length(uniqueAllInputValues));

for j=1:length(nominalInput) %build Mat for all rows
    %if a NAN value is found at nominalInput(j), then replace all values in
    %'dummyEncodingMat' with NAN
    if nanPossible && isnan(nominalInput(j))
        dummyEncodingMat(j,:) = nan;
    else
        idx = find(uniqueAllInputValues==nominalInput(j));
        dummyEncodingMat(j,idx) = 1;
    end
end

[~, dvColumns] = size(dummyEncodingMat);
dummyVariableLastColumnDropped = dummyEncodingMat(:, 1:dvColumns-1);
