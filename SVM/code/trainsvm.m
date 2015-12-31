function [predW, bias] = trainsvm(xTr, yTr, C)

n = size(xTr,1);
m = size(xTr,2);

Q = [eye(m) zeros(m,n+1) ; zeros(n+1, m) zeros(n+1,n+1)]; %%% H matrix
%Q = Q./2;
c = [zeros(m+1,1) ; ones(n,1)*C]; %%% f vector


yr = repmat(yTr,m,1);
yrs = reshape(yr,n,m); % nxm matrix with repeated y(train.label)
xy = yrs .* xTr;

A = [xy yTr eye(n)]; %%% A matrix
A = A .* -1;
g = ones(n,1)*-1; %%% b vector

%lb = zeros(m+1+n,1);
lb = [-inf(m+1,1); zeros(n, 1)];

options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
z = quadprog(Q, c, A, g, [],[],lb,[],[], options);

predW = z(1:m);
bias = z(m+1);