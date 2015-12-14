% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 20-Nov-2015 %
% Version   : 1.0v %
% This function uses the test data to perform testing of the binary classifier %
% By doing so, it checks the accuracy of the training %
function [comparisonMatrix, result] = multiClassSVMTestOVO(Xtest, Ytest, classes, w, b, pairs)
sizeTestData = size(Xtest, 1);
classesTemp = zeros(4, 1);
Yguess = Ytest;
Xtest = str2double(Xtest);
for i = 1: size(Xtest, 1)
    for j = 1: size(pairs, 1)
        if (w(j, :)) * (Xtest(i, :)') + b(j) >= 0
            classesTemp(pairs(j, 1)) = classesTemp(pairs(j, 1)) + 1;
        else
            classesTemp(pairs(j, 2)) = classesTemp(pairs(j, 2)) + 1;
        end
    end
 
    max = 0;
    highestIndex = 0;
    for j = 1:size(classesTemp, 1)
        temp = classesTemp(j);
        if temp > max
            highestIndex = j;
            max = temp;
        end
    end
    Yguess(i) = classes(highestIndex);
    classesTemp = zeros(4, 1);
end

result = 0;
comparisonMatrix = repmat('Unmatched', [sizeTestData 1]);
for i = 1:sizeTestData
    if strcmp(Ytest(i), Yguess(i))
        result = result + 1;
        comparisonMatrix(i, 1:9) = char('ItMatched');
    end
end


