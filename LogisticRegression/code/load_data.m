function [trainCell, trainSurv, testCell, testSurv] = load_data(raw)
    rows = length(raw); % total rows in raw
    cols = length(raw(1,:));


    disp('Empty values for columns:');
    for col=1:cols
        count = 0;
        for row=2:rows % not column headers
            if any(isnan(raw{row,col})) == 1
                count = count + 1;
            end 
        end
        fprintf('Missing values for %s - %d \n',raw{1,col}, count);
    end

    % need to shuffle all rows randomly
    noHeaderRaw = raw(2:rows,:); % removing headers
    rows = length(noHeaderRaw); % new length after removing headers
    randomRows = randperm(rows);
    randomNoHeaderRaw = cell(rows,cols);

    for j=1:rows
       randomNoHeaderRaw(j,:) = noHeaderRaw(randomRows(j),:);
    end
    
    % removing 2nd column from randomNoHeaderRaw cell and storing in
    % survived array
    colsAfterRemoved = cols-1;
    randomNoHeaderSurvivedRemovedRaw = cell(rows, colsAfterRemoved);
    survived = zeros(rows,1);
    for j=1:rows
        randomNoHeaderSurvivedRemovedRawIndex = 1;
        for k=1:cols
            if k==2
                survived(j) = randomNoHeaderRaw{j,k};
            else
                randomNoHeaderSurvivedRemovedRaw(j,randomNoHeaderSurvivedRemovedRawIndex) = randomNoHeaderRaw(j,k);
                randomNoHeaderSurvivedRemovedRawIndex = randomNoHeaderSurvivedRemovedRawIndex + 1;
            end
        end
    end
    
    % divide random raw data with no header and survived removed into training(50%) and test(50%)
    trainRows = round(rows/2);
    trainSurv = survived(1:trainRows);
    testSurv = survived(trainRows+1:rows);
    trainCell = randomNoHeaderSurvivedRemovedRaw(1:trainRows,:);
    testCell = randomNoHeaderSurvivedRemovedRaw(trainRows+1:rows,:);
