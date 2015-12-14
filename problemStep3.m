% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 19-Nov-2015 %
% Version   : 1.0v %
% This program laods the vehicle data and implements %
% the error?correcting?coding extension of binary SVM for multi?class recognition.  

% load data from the data files %
function[] = problemStep3(C) % C soft margin parameter for tuning classifier
[xaaD, xaaC] = loadDataFromFile('xaa.dat');
[xabD, xabC] = loadDataFromFile('xab.dat');
[xacD, xacC] = loadDataFromFile('xac.dat');
[xadD, xadC] = loadDataFromFile('xad.dat');
[xaeD, xaeC] = loadDataFromFile('xae.dat');
[xafD, xafC] = loadDataFromFile('xaf.dat');
[xagD, xagC] = loadDataFromFile('xag.dat');
[xahD, xahC] = loadDataFromFile('xah.dat');
[xaiD, xaiC] = loadDataFromFile('xai.dat');


finalX = [xaaD; xabD; xacD; xadD; xaeD; xafD; xagD];
finalY = [xaaC; xabC; xacC; xadC; xaeC; xafC; xagC];

classes = unique(finalY);
Xtest = [xahD; xaiD];
Ytest = [xahC; xaiC];

% prepare the data structure needed for the training %
code_mat = [ 1 -1 -1 -1  1  1  1;
            -1  1 -1 -1  1 -1 -1;	  
            -1 -1 +1 -1 -1 +1 -1;
            -1 -1 -1  1 -1 -1  1;];
        
%  index_classes = containers.Map;
index_classes = {'bus' ; 'van' ; 'opel' ; 'saab'};

column_size = size(code_mat,2);
w = zeros(column_size, size(finalX, 2));
b = zeros(column_size, 1);

YtrainTemp = zeros(size(finalY, 1), 1);
XtrainTemp = str2double(finalX);

% loop through every column of every code matrix %
for i = 1:column_size
    for counter = 1: size(finalY, 1)
        indexHolder = -1;
        for j = 1: size(index_classes, 1)
            if (strcmp(strtrim(index_classes(j)), strtrim(finalY(counter))))
               indexHolder = j;
            end
        end
        YtrainTemp(counter,:) = code_mat(indexHolder, i);
    end
    z(i, :) = binarySVMTrain(XtrainTemp, YtrainTemp, C);
    w(i, :) = z(i, 1:18);
    b(i, :) = z(i, 19);

end

% Perform a test on the testing data %
[comparisonMatrix, result] = multiClassSVMTestECC(Xtest, Ytest, column_size, index_classes, w, b, code_mat);
disp(strcat('Total test data matched is : ', num2str(result)));
disp (strcat('The comparison report is : ', comparisonMatrix));








