% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 15-Nov-2015 %
% Version   : 1.0v %
% This function uses QuadProg to train a binary SVM %
% It uses the QuadProg(Q,c,A,g) for getting the vector Z %
% And there after calculates the matrix Q %
function [z] = binarySVMTrain(Xtrain, Ytrain, C)
% Initialize the matrices %
m = size(Xtrain, 2);
n = size(Xtrain, 1);
I = eye(m);
O1 = zeros(m, n + 1);
O2 = zeros(n + 1, m);
O3 = zeros(n + 1, n + 1);
Q = [I, O1; O2 O3];

% Calculate the c matrix %
Oc = zeros(m + 1, 1);
Ic = C * ones(n, 1);
c = [Oc; Ic];

% Calculate the g matrix %
Ig = ones(1, n);
Og = zeros(1, n);
g = (- 1 * [Ig, Og])';

% Calculate the A matrix %
A = calculateA(Xtrain, Ytrain);

% Computing the z matrix %
z = quadprog(Q, c, A, g);

