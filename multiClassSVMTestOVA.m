% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 20-Nov-2015 %
% Version   : 1.0v %
% This function uses the test data to perform testing of the binary classifier %
% By doing so, it checks the accuracy of the training %
function [comparisonMatrix, result, Yguess] = multiClassSVMTestOVA(Xtest, Ytest, classes, z, w, b)
sizeTestData = size(Xtest, 1);
Yguess = Ytest;
Xtest = str2double(Xtest);
for i = 1:sizeTestData
    classGuessedIndex = 0;
    for j = 1: size(classes, 1)
        temp = (w(j, :)) * (Xtest(i, :)') + b(j);
        if (j == 1)
            maxValue = temp;
        end
        if temp >= maxValue
            maxValue = temp;
            classGuessedIndex = j;
        end
    end
    Yguess(i) = classes(classGuessedIndex);
end
result = 0;
comparisonMatrix = repmat('Unmatched', [sizeTestData 1]);
for i = 1:sizeTestData
    if strcmp(Ytest(i), Yguess(i))
        result = result + 1;
        comparisonMatrix(i, 1:9) = char('ItMatched');
    end
end
