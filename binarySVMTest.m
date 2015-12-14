% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 15-Nov-2015 %
% Version   : 1.0v %
% This function uses the test data to perform testing of the binary classifier %
% By doing so, it checks the accuracy of the training %
function [comparisonMatrix, result] = binarySVMTest(Xtest, Ytest, z, w, b, size)
Yguess = zeros(size, 1);
for i = 1:size
    if (w')*(Xtest(i,:)') + b >= 0
        Yguess(i) = 1;
    else
        Yguess(i) = - 1;
    end
end
result = 0;
comparisonMatrix = repmat('Unmatched', [size 1]);
for i = 1:size
    if Ytest(i) == Yguess(i)
        result = result + 1;
        comparisonMatrix(i, 1:9) = char('ItMatched');
    end
end