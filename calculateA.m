% Author	: Saurabh Singh, Ashish Kumar %
% Date		: 15-Nov-2015 %
% Version	: 1.0v %
% This function computes the A matrix %
function [A] = calculateA(Xtrain,Ytrain)
m = size(Xtrain,2);
n = size(Xtrain,1);
A = zeros(2*n,n+m+1);
for i = 1:n
    A(i,:) = -1*[Ytrain(i)*Xtrain(i,:),Ytrain(i),zeros(1,i-1),1,zeros(1,n-i)];
end
for i = 1:n
    A(n+i,:) = -1*[zeros(1,m+1),zeros(1,i-1),1,zeros(1,n-i)];
end
