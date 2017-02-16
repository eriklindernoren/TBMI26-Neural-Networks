load countrydata;

X = countrydata;
Y = countryclass;

cov = calc_covariance_matrix(X);

[eigenvectors, eigenvalues] = sorteig(cov);

% Project X onto two first principal components
a = eigenvectors(:,1)'*X;
b = eigenvectors(:,2)'*X;

% Find the index of Georgia
idx = find(all(ismember(countries,'Georgia     '),2));

% Set Georgia to new color
Y(idx) = 3;

% Plot
scatter(a, b, 15, Y);
