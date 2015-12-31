function [refEstimate, refXValues] = get_reference_estimate_from_all_data(x_tr,x_te)
% This fucntion returns an estimated density estimator curve using ALL data
% (both x_tr and x_te) and using the ksdensity matlab function.  
% This is ONLY USED as a comparison to the various kernels implemented in
% 5(a).

    trainAndTestData=zeros(length(x_tr)+length(x_te), 1);
    trainAndTestData(1:length(x_tr))=x_tr;
    trainAndTestData(length(x_tr)+1:length(trainAndTestData))=x_te;
    [refEstimate, refXValues] = ksdensity(trainAndTestData);

end