function [mat] = normalise_matrix(mat)
    matSize = size(mat);
    matLength = matSize(1);
    matFeatures = matSize(2);
    
    for gg=1:matFeatures % to normalize all features
        matFeatureMean=mean(mat(:,gg));
        matFeatureSd=std(mat(:,gg));
        for ff=1:matLength % iterate over feature values
           mat(ff,gg) = (mat(ff,gg)-matFeatureMean)/matFeatureSd; 
        end
    end
end