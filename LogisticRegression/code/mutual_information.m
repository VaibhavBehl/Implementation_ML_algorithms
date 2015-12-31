function [mi] = mutual_information(yOrig, Y,X)
    % no NaN values in either of Y or X
    % method will try to descritize automatic if unique(X)>10

    % calculating Mutual Information
    uniqueYOrig = transpose(unique(yOrig));
    uniqueY = transpose(unique(Y));
    uniqueX = transpose(unique(X));
    
    % finding H(Y)
    sumhy = 0;
    for yi=uniqueYOrig
        pyi = sum(yOrig==yi)/length(yOrig);
        sumhy = sumhy + pyi*log(pyi);
    end
    hy = -sumhy;
    
    % finding H(Y|X) = sumVx( P(xi) sumVy( P(yi|xi)logP(yi|xi) ) )
    hyx = 0;
    if length(uniqueX) <= 10
        for xi = uniqueX
            pxi = sum(ismember(X,xi))/length(X);

            % finding H(Y|X=xi)
            hyxx = 0;
            for yi=uniqueY
                yValuesForXiIndices = Y(ismember(X,xi));
                pyxi = sum(yValuesForXiIndices==yi)/sum(ismember(X,xi));% P(Y=yi|X=xi)
                if pyxi~= 0
                    hyxx = hyxx + pyxi*log(pyxi);
                end
            end
            hyx = hyx + pxi*hyxx;
        end
    else % sort and discritise 'X' it into 10 equal density bins
        [sv,si] = sort(X);
        X=sv;
        Y=Y(si); % Y also sorted acc to new indices of X
        binNumber=10;
        frac = round(length(X)/binNumber);
        % binI = 1,2,3,4,5... 10 bins... frac = length(si)/10 .. si[1:frac]
        % .. si[frac+1 
        for j=1:binNumber
            if j~=binNumber
                %subX = X((j-1)*frac+1:j*frac);
                subY = Y((j-1)*frac+1:j*frac);
            else %for last bin include all remaining
                %subX = X((j-1)*frac+1:length(X));
                subY = Y((j-1)*frac+1:length(Y));
            end
            
            pxi = frac/length(X);

            % finding H(Y|X=xi)
            hyxx = 0;
            for yi=uniqueY
                yValuesForXInJBin = subY;
                pyxi = sum(yValuesForXInJBin==yi)/length(yValuesForXInJBin);% P(Y=yi|X=xbinJ)
                if pyxi~= 0
                    hyxx = hyxx + pyxi*log(pyxi);
                end
            end
            hyx = hyx + pxi*hyxx;
        end
        
    end
    
    % I(X;Y) = H(Y) - H(Y|X)
    mi = hy-hyx;
    
end