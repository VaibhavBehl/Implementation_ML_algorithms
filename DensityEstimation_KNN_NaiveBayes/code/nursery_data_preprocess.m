function [nursery_data, nursery_label] = nursery_data_preprocess(data_file)
% preprocessing for nursery dataset
% Input:
%  data_file: file to read the data from. Should be in csv format with 
%  8 features followed by one class. Example of a sample data-
%  usual,less_proper,foster,more,less_conv,inconv,nonprob,priority,priority
%
%     | class values
% 
%     not_recom, recommend, very_recom, priority, spec_prior
% 
%     | attributes
% 
%     parents:     usual, pretentious, great_pret.
%     has_nurs:    proper, less_proper, improper, critical, very_crit.
%     form:        complete, completed, incomplete, foster.
%     children:    1, 2, 3, more.
%     housing:     convenient, less_conv, critical.
%     finance:     convenient, inconv.
%     social:      nonprob, slightly_prob, problematic.
%     health:      recommended, priority, not_recom.
%
% Output:
%  nursery_data: matrix of size NX27 or NXD (N: total samples, D: total features after 
%  pre-processing, which is 27)
%  nursery_label: column vector of dimension NX1.

%Maps for Features below-
%D value for 8 attributes/features will be 27 after conversion(K binary)
%parent
parentObj = containers.Map({'usual', 'pretentious', 'great_pret'}, {dec2bin(1,3), dec2bin(2,3), dec2bin(4,3)});
%has_nurs
hasNursObj = containers.Map({'proper', 'less_proper', 'improper', 'critical', 'very_crit'}, {dec2bin(1,5), dec2bin(2,5), dec2bin(4,5), dec2bin(8,5), dec2bin(16,5)});
%form
formObj = containers.Map({'complete', 'completed', 'incomplete', 'foster'}, {dec2bin(1,4), dec2bin(2,4), dec2bin(4,4), dec2bin(8,4)});
%children
childrenObj = containers.Map({'1', '2', '3', 'more'}, {dec2bin(1,4), dec2bin(2,4), dec2bin(4,4), dec2bin(8,4)});
%housing
housingObj = containers.Map({'convenient', 'less_conv', 'critical'}, {dec2bin(1,3), dec2bin(2,3), dec2bin(4,3)});
%finance
financeObj = containers.Map({'convenient', 'inconv'}, {dec2bin(1,2), dec2bin(2,2)});
%social
socialObj = containers.Map({'nonprob', 'slightly_prob', 'problematic'}, {dec2bin(1,3), dec2bin(2,3), dec2bin(4,3)});
%health
healthObj = containers.Map({'recommended', 'priority', 'not_recom'}, {dec2bin(1,3), dec2bin(2,3), dec2bin(4,3)});

%Map for Class values ->
%label will be numeric from 1 to M(where M is no. of total classes)
%class
classObj = containers.Map({'not_recom', 'recommend', 'very_recom', 'priority', 'spec_prior'}, {1, 2, 3, 4, 5});

%Main map object with reference to all other maps by order
mainMapObj = containers.Map({1,2,3,4,5,6,7,8,9}, {parentObj, hasNursObj, formObj, childrenObj, housingObj, financeObj, socialObj, healthObj, classObj});

nurseryData = importdata(data_file);
nursery_data = zeros(length(nurseryData), 27);
nursery_data(:)=-1;
nursery_label = zeros(length(nurseryData), 1);
nursery_label(:)=-1;

for index=1:length(nurseryData) %iterate across the length of data samples(N)
    stringData = strsplit(char(nurseryData(index)), ','); % select one sample
    stringDataIndex=1;
    nursery_data_column_index=1;
    while stringDataIndex <= 8 % iterate total features/Attributes in one line
        featureObjMap = mainMapObj(stringDataIndex);
        mapValue = featureObjMap(char(stringData(stringDataIndex)));
        for ii=mapValue
            nursery_data(index, nursery_data_column_index)=str2num(ii);
            nursery_data_column_index = nursery_data_column_index + 1;
        end
        stringDataIndex = stringDataIndex + 1;
    end
    classObjMap = mainMapObj(stringDataIndex);
    mapValue = classObjMap(char(stringData(stringDataIndex))); % get class 
    nursery_label(index, 1)= mapValue;
end