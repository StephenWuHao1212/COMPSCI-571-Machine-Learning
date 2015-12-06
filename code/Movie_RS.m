%  Load data

%original_data = load('ratings.dat');
%original_data = original_data(:, 1:3);
%Y_m = sparse(original_data(:, 2), original_data(:, 1), original_data(:, 3));
%R_m = sparse(original_data(:, 2), original_data(:, 1), ones(size(original_data, 1), 1));
%Y_m = full(Y_m);
%R_m = full(R_m);

load('ratings.mat');

%  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies by 
%  943 users
%
%  R is a 1682x943 matrix, where R(i,j) = 1 if and only if user j gave a
%  rating to movie i

%  Add our own ratings to the data matrix

% Y = [my_ratings Y];
% R = [(my_ratings ~= 0) R];

%  Normalize Ratings
Y_test = Y(:, 901:943);
Y_origin = Y;
Y(1:100, 901:943) = zeros(100, 43);
R_origin = R;
R(1:100, 901:943) = zeros(100, 43);
[Ynorm, Ymean] = normalizeRatings(Y, R);

%  Useful Values
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;

% Set Initial Parameters (Theta, X)
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');


p = X * Theta';
for i = 901:943
   p(:, i) = p(:,i) + Ymean;
end
my_predictions = p(:, 901:943);


[r, ix] = sort(my_predictions, 'descend');
