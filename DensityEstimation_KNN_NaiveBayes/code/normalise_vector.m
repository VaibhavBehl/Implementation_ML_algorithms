function [vector, vMean, vSD] = normalise_vector(vector)
    vectorLength = length(vector);
    
    vMean=mean(vector);
    vSD=std(vector);
    for row=1:vectorLength % iterate over feature values
       vector(row) = (vector(row)-vMean)/vSD; 
    end
end