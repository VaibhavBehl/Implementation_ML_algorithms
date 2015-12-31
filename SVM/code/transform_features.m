function [newFeat] = transform_features(feat)

N = size(feat,1);
M = size(feat,2);

typeA = [-1;0;1];
typeB = [0;1];
typeC = [-1;1];


newM = 8*3 + 22;
newFeat = zeros(N, newM)*inf;
for i=1:N % rows
    jNew = 1;
    for j=1:M % columns
        unqF = unique(feat(:,j));
        if isequal(unqF, typeA) || isequal(unqF, typeB) %make 3 new features
            if feat(i,j) == -1
                newFeat(i,jNew) = 1;jNew = jNew + 1;
                newFeat(i,jNew) = 0;jNew = jNew + 1;
                newFeat(i,jNew) = 0;jNew = jNew + 1;
            elseif feat(i,j) == 0
                newFeat(i,jNew) = 0;jNew = jNew + 1;
                newFeat(i,jNew) = 1;jNew = jNew + 1;
                newFeat(i,jNew) = 0;jNew = jNew + 1;
            elseif feat(i,j) == 1
                newFeat(i,jNew) = 0;jNew = jNew + 1;
                newFeat(i,jNew) = 0;jNew = jNew + 1;
                newFeat(i,jNew) = 1;jNew = jNew + 1;
            end
        elseif isequal(unqF, typeC) % leave as-it-is
            newFeat(i,jNew) = feat(i,j);jNew = jNew + 1;
        else
            disp('warning: not matched any equality');
        end
    end
end

