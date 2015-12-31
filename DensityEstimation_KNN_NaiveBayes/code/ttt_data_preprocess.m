function [ttt_data, ttt_label] = ttt_data_preprocess(data_file)
% preprocessing for ttt dataset
% Input:
%  data_file: file to read the data from. Should be in csv format with 
%  9 features followed by one class. Example of a sample data-
%  x,x,x,x,o,b,o,o,b,positive
%
% Output:
%  ttt_data: matrix of size NX27 or NXD (N: total samples, D: total 
% features after pre-processing, which is 27)
%  ttt_label: column vector of dimension NX1.

mapObj = containers.Map({'x', 'o', 'b', 'positive', 'negative'}, {dec2bin(1,3), dec2bin(2,3), dec2bin(4,3), 1, 2});

tttData = importdata(data_file);
ttt_data = zeros(length(tttData), 27);
ttt_data(:)=-1;
ttt_label = zeros(length(tttData), 1);
ttt_label(:)=-1;

for index=1:length(tttData) %iterate across the length of data samples(N)
    stringData = strsplit(char(tttData(index)), ','); % select one sample
    stringDataIndex=1;
    ttt_data_column_index=1;
    while stringDataIndex <= 9 % iterate total features (9- xoxxxoobx)
        mapValue = mapObj(char(stringData(stringDataIndex)));
        for ii=mapValue
            ttt_data(index, ttt_data_column_index)=str2num(ii);
            ttt_data_column_index = ttt_data_column_index + 1;
        end
        stringDataIndex = stringDataIndex + 1;
    end
    mapValue = mapObj(char(stringData(stringDataIndex))); % get class 
    ttt_label(index, 1)= mapValue;
end