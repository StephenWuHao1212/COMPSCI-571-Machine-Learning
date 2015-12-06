%data = csvread('/Users/hongjin/Downloads/ml-1m/ratings.dat');
%data = data(:, 1:3);

%num_movies = 3952;
%num_users = 6040;

original_data = load('ratings.dat');
original_data = original_data(:, 1:3);
num_movies = 3952;
num_users = 6040;
Y_m = sparse(original_data(:, 2), original_data(:, 1), original_data(:, 3));
R_m = sparse(original_data(:, 2), original_data(:, 1), ones(size(original_data, 1), 1));



