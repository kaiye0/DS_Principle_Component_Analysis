clear; clc;
num = 3000;
%each column is 3-dimensional zero-mean Gaussian random vector
X = randn(3,num); 

%add a covariance matrix of rank r
r = 2;
A = randn(3,3);
B = orth(A);
eig1 = [ones(r,1); zeros(3-r,1)];%p1
eig2 = [rand(r,1); zeros(3-r,1)];%p3
eig3 = [1; 0.01; 0];%p4
C = diag(eig3);
Y = B*sqrt(C)*X;

%plot the point cloud
scatter3(Y(1,:), Y(2,:), Y(3,:),'.'); axis equal

