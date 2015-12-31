function [X] = get_combined_matrix_X(tCell, allCell)
% returns a combined matrix X from cell data
% For categorical values, we'll ALWAYS drop the last column to prevent
% 'Dummy variable trap'

% dv - summy variable
dvSex = get_dummy_encoding_drop_one(nominal(tCell(:,3)), nominal(allCell(:,3)), false);
dvPclass = get_dummy_encoding_drop_one(cell2mat(tCell(:,1)), cell2mat(allCell(:,1)), false);
fare = cell2mat(tCell(:,8));
fare(isnan(fare)) = 33.2955;

embarked = tCell(:,10);
nanFun = @(x) any(isnan(x));
if sum(cellfun(nanFun, embarked)) > 0
    embarked(cellfun(nanFun, embarked)) = {'S'};
end
embarkedAll = allCell(:,10);
if sum(cellfun(nanFun, embarkedAll)) > 0
    embarkedAll(cellfun(nanFun, embarkedAll)) = {'S'};
end
dvEmbarked = get_dummy_encoding_drop_one(nominal(embarked), nominal(embarkedAll), false);

parch=cell2mat(tCell(:,6));
sibsp=cell2mat(tCell(:,5));
age = cell2mat(tCell(:,4));

%dvSex(1) dvPclass(2,3) fare(4) dvEmbarked(5,6) parch(7) sibsp(8) age(9)
X = [dvSex dvPclass fare dvEmbarked parch sibsp age];