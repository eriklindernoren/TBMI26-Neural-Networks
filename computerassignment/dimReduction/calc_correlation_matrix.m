function C = calc_correlation_matrix( X )

    covariance = calc_covariance_matrix(X);
    std_dev = sqrt(diag(covariance));
    C = covariance ./ (std_dev*std_dev');
    
end
