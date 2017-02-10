load countrydata;

X = countrydata;

X_developing = X(:, find(Y == 0));
X_industrialized = X(:, find(Y == 2));

X_developing = X_developing(:, 1:26);

cov_dev = calc_covariance_matrix(X_developing);
cov_ind = calc_covariance_matrix(X_industrialized);
cov_tot = cov_dev + cov_ind;

mean_dev = mean(X_developing, 2);
mean_ind = mean(X_industrialized, 2);
mean_diff = mean_dev - mean_ind;

w = cov_tot\mean_diff;

X_both = X(:, find(Y == 0 | Y == 2));
Y_both = Y(find(Y == 0| Y == 2));

% Plot with original w
figure(1)
scatter(w'*X_both, w'*X_both, 10, Y_both)

% Set noicy (?) axises to zero
w(find(abs(w) < 0.03)) = 0;

% Plot with some axises in w removed
figure(2)
scatter(w'*X_both, w'*X_both, 10, Y_both)



