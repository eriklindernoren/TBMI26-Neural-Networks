function C = calc_covariance_matrix( X )

    m = mean(X,2);
    x_mean = diag(m)*ones(size(X));
    N = numel(X(1,:));
    C = (1/N)*(X-x_mean)*(X-x_mean)';
    

end
