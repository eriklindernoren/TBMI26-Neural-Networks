load countrydata;

X = normr(countrydata);
Y = countryclass;

cov = calc_covariance_matrix(X);
corr = calc_correlation_matrix(X);

imagesc(corr)

[eigenvectors, eigenvalues] = sorteig(cov);

eigenvalues

% Project X onto two first principal components
x1 = eigenvectors(:,1)'*X;
x2 = eigenvectors(:,2)'*X;

% Find the index of Georgia
idx = find(all(ismember(countries,'Georgia     '),2));

% Georgia
Y(idx) = 3;

gscatter(x1, x2, Y);