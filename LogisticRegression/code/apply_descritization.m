function [input] = apply_descritization(descritizationPts, input)
% will descritize 'input' array according to descritizationPts
% all values in 'input' less than/equal to one point in 'descritizationPts' will be labeled with that points

for j=1:length(input)
    if not(isnan(input(j)))
        inputVal = input(j);
        descreteVal = descritizationPts(1);
        for k=2:length(descritizationPts)
            if descritizationPts(k) > inputVal
                break;
            end
            descreteVal = descritizationPts(k);
        end
        input(j) = descreteVal; 
    end
end