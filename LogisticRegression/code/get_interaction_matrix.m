function [interactionMat] = get_interaction_matrix(inputMat)


[rowInput, colInput] = size(inputMat);

colsInteractionMat = 0;
for j=1:colInput
    for i=j:colInput
        if j<i
            colsInteractionMat = colsInteractionMat + 1;
        end
    end
end

interactionMat = zeros(rowInput, colsInteractionMat);

index=1;
for j=1:colInput
    for i=j:colInput
        if j<i
            interactionMat(:,index) = inputMat(:,i).*inputMat(:,j);
            index = index + 1;
        end
    end
end