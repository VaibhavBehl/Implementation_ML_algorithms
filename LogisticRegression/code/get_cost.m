function gradient = get_cost(tx, tSurv, theta)
    sigmaFun = inline('1.0 ./ (1.0 + exp(-z))'); 
    hyTheta = tSurv - sigmaFun(tx*theta');
    gradient = hyTheta'*tx;
    gradient = gradient';
end