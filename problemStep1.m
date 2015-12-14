% Author    : Saurabh Singh, Ashish Kumar %
% Date      : 19-Nov-2015 %
% Version   : 1.0v %
% This program laods the vehicle data and creates performs %
% a one vs all multiclass conversion from the binary SVM %
% created in the process %
function[] = problemStep1(C)  % C soft margin parameter for tuning classifier
% load data from the data files %
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

% loop through the classes matrix for one vs all conversion %
z = zeros(4, (size(finalX, 2) + size(finalX, 1) + 1));
w = zeros(4, size(finalX, 2));
b = zeros(4, 1);
for i = 1:size(classes)
    tempY = zeros(size(finalY, 1), 1);
    tempX = str2double(finalX);
    for j = 1:size(finalY)
        if (strcmp(classes(i), finalY(j)))
            tempY(j) = 1;
        else
            tempY(j) = - 1;
        end
    end
    z(i, :) = binarySVMTrain(tempX, tempY, C);
    w(i, :) = z(i, 1:size(tempX, 2));
    b(i, :) = z(i, (size(tempX, 2) + 1));
end

% test against the test data %
[comparisonMatrix, result] = multiClassSVMTestOVA(Xtest, Ytest, classes, z, w, b);
disp(strcat('Total test data matched is : ', num2str(result)));
disp(strcat('The comparison report is : ', comparisonMatrix));


