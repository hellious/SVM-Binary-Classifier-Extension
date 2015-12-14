% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 20-Nov-2015 %
% Version   : 1.0v %
% This function uses the test data to perform testing of the Error code correcting classifier %
% By doing so, it checks the accuracy of the training %
function [comparisonMatrix, result] = multiClassSVMTestECC(Xtest, Ytest, column_size, index_classes, w, b, code_mat)
Xtest = str2double(Xtest);
sizeTestData = size(Xtest, 1);
Yguess = Ytest;

% creating row vector for each sample for 7 hyper plane %
sub_vect = zeros(sizeTestData,column_size);

% calculating the final sub_vect to find out eucladean dist %
for i = 1: sizeTestData
    for j = 1: column_size
        if((w(j, :)) * (Xtest(i, :)') + b(j)) >= 0    % a point is more than 0 for given weight, then we store it as 1 in sub_vector%          
            sub_vect(i,j) = 1;
        else
            sub_vect(i,j) = -1;
        end
    end
end

% now we have to caluclate euclidean distance %
for i = 1: sizeTestData
    min_val = 0;
    index_max = 0;
    eul_dist = 0;
    for j = 1: size(index_classes, 1)
        eul_dist = pdist2(sub_vect(i,:),code_mat(j,:));
        if(j == 1)
            min_val = eul_dist;
            index_max = j; 
        else
            if eul_dist < min_val;
                min_val = eul_dist;
                index_max = j;
            end
        end
    end
    Yguess(i) = index_classes(index_max);
end

result = 0;
comparisonMatrix = repmat('Unmatched', [sizeTestData 1]);
for i = 1:sizeTestData
    if (strcmp(strtrim(Ytest(i)), strtrim(Yguess(i))))
        result = result + 1;
        comparisonMatrix(i, 1:9) = char('ItMatched');
    end
end
