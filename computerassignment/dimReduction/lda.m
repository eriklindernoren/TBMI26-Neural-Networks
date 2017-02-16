load countrydata;

X = countrydata;
Y = countryclass;

% Separate the data into one bin for each class
X_developing = X(:, find(Y == 0));
X_industrialized = X(:, find(Y == 2));

X_developing = X_developing(:, 1:26);

% Calculate the covariance (spread) of each class distribution and
% add them.
cov_dev = calc_covariance_matrix(X_developing);
cov_ind = calc_covariance_matrix(X_industrialized);
cov_tot = cov_dev + cov_ind;

% Get the means of each class distrubution and calculate
% the distance between them.
mean_dev = mean(X_developing, 2);
mean_ind = mean(X_industrialized, 2);
mean_diff = mean_dev - mean_ind;

% Calculate weights as distance between class means divided by the
% sum of their covariance
w = cov_tot\mean_diff;

w

X_both = X(:, find(Y == 0 | Y == 2));
Y_both = Y(find(Y == 0| Y == 2));

% Plot
figure(1)
scatter(w'*X_both, w'*X_both, 10, Y_both)


